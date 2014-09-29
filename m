From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 29 Sep 2014 17:08:37 +0200
Subject: [PATCH v6 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <1411468088-5702-8-git-send-email-antoine.tenart@free-electrons.com>
References: <1411468088-5702-1-git-send-email-antoine.tenart@free-electrons.com>
 <1411468088-5702-8-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140929150837.GD8912@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter, Arnd, Felipe,

On Tue, Sep 23, 2014 at 12:28:03PM +0200, Antoine Tenart wrote:
> Add a USB2 ChipIdea driver for ci13xxx, with optional PHY, clock
> and DMA mask, to support USB2 ChipIdea controllers that don't need
> specific functions.

Did we agree on the modifications needed to get this accepted? If so,
can one of you sum up what's need to be done, I got a bit lost reading
all the discussions on this thread.

Anyway, that would be good to get this series accepted as the Berlin USB
support depends on it. This series has been out since the beginning of
June and non-critical changes can be added by future series.

Thanks,

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
