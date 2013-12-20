From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 19 Dec 2013 19:21:33 -0800
Subject: [PATCH 2/4] misc: xgene: Add base driver for APM X-Gene SoC
 Queue Manager/Traffic Manager
In-Reply-To: <1387507503-7565-3-git-send-email-rapatel@apm.com>
References: <1387507503-7565-1-git-send-email-rapatel@apm.com>
 <1387507503-7565-3-git-send-email-rapatel@apm.com>
Message-ID: <20131220032133.GB32310@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 06:45:01PM -0800, Ravi Patel wrote:
> This patch adds APM X-Gene SoC Queue Manager/Traffic Manager base driver.
>  QMTM is requried by Ethernet, PktDMA and Security Engine subsystems.

How does this driver talk to userspace?  Or is it just a "bus" for
devices to attach to and use to talk to the real devices in the system?
If so, why isn't it represented in the driver model?

thanks,

greg k-h
