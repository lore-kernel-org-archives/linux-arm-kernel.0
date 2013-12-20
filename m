From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 19 Dec 2013 19:22:17 -0800
Subject: [PATCH 0/4] misc: xgene: Add support for APM X-Gene SoC Queue
 Manager/Traffic Manager
In-Reply-To: <1387507503-7565-1-git-send-email-rapatel@apm.com>
References: <1387507503-7565-1-git-send-email-rapatel@apm.com>
Message-ID: <20131220032217.GC32310@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 06:44:59PM -0800, Ravi Patel wrote:
> This patch adds support for APM X-Gene SoC Queue Manager/Traffic Manager.
>  QMTM is required by APM X-Gene SoC Ethernet, PktDMA and Security Engine
>  subsystems. All subsystems communicate with QMTM using messages which
>  include information about the work to be performed and the location of
>  associated data buffers.

And finally, where are the drivers that are going to use these apis you
are creating here?  Where are they going to live, and when are they
going to be submitted?

thanks,

greg k-h
