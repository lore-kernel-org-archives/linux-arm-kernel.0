From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 19 Dec 2013 19:40:04 -0800
Subject: [PATCH 0/4] misc: xgene: Add support for APM X-Gene SoC Queue
 Manager/Traffic Manager
In-Reply-To: <CAN1v_PsibDTwQ9_ZxRnBtJA46BPne6fTuS_9TddWPZt6ewwgQQ@mail.gmail.com>
References: <1387507503-7565-1-git-send-email-rapatel@apm.com>
 <20131220032217.GC32310@kroah.com>
 <CAN1v_PsibDTwQ9_ZxRnBtJA46BPne6fTuS_9TddWPZt6ewwgQQ@mail.gmail.com>
Message-ID: <20131220034004.GA8160@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Dec 19, 2013 at 07:27:35PM -0800, Ravi Patel wrote:
> APM X-Gene SoC Ethernet driver is planned to be submitted on Dec 20 2013.
> Ethernet driver will be using these exported API's from QMTM driver.

Please submit a user of the api as part of the series, otherwise we
can't evaluate if it's really the correct thing to do or not.

> The APM X-Gene SoC Ethernet driver is going to live in?drivers/net/ethernet/apm
> /xgene.

So this is a "bus"?  How is the ethernet device going to show up in
sysfs as a parent of what as this isn't part of the driver model?

greg k-h
