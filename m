From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 16 Nov 2016 16:48:24 +0000
Subject: [PATCH] bus: vexpress-config: fix device reference leak
In-Reply-To: <1477997017-29103-1-git-send-email-johan@kernel.org>
References: <1477997017-29103-1-git-send-email-johan@kernel.org>
Message-ID: <5ced7446-571c-c022-6392-3e78e3c22193@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/11/16 10:43, Johan Hovold wrote:
> Make sure to drop the reference to the parent device taken by
> class_find_device() after populating the bus.
>

Thanks for the fix. I somehow missed this patch, sorry for that.
Not sure if arm-soc guys take this as a fix for v4.9, and I have already
sent PR for v4.10. I will repost this along with the ack and check with
them.

-- 
Regards,
Sudeep
