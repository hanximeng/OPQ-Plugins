local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")

function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end
function ReceiveGroupMsg(CurrentQQ, data)
	if string.find(data.Content, "毒鸡汤") == 1 then
		response, error_message =
		    http.request(
		    "GET",
		    "https://api.hanximeng.com/soul/api.php",
		    {
		        query = "type=text",
		        headers = {
		            ["Accept"] = "*/*",
								["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36"
		        }
		    }
		)
		local html = response.body
		log.notice("毒鸡汤--->%s", html)
		Api.Api_SendMsg(--调用发消息的接口
		    CurrentQQ,
		    {
		        toUser = data.FromGroupId, --回复当前消息的来源群ID
		        sendToType = 2, --2发送给群1发送给好友3私聊
		        sendMsgType = "TextMsg", --进行文本复读回复
		        groupid = 0, --不是私聊自然就为0咯
		        content = html, --回复内容
		        atUser = 0 --是否 填上data.FromUserId就可以复读给他并@了
		    }
		)
	end
    return 1
end
function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end

	