From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 16 Aug 2016 21:58:43 +0200 (CEST)
Subject: [PATCH V2 RFC 6/6] ARM: dts: bcm2835: Add Raspberry Pi Zero
In-Reply-To: <722dafcb-2f67-88c7-69df-d442c56c058f@synopsys.com>
References: <1469559213-16160-1-git-send-email-stefan.wahren@i2se.com>
 <1469559213-16160-7-git-send-email-stefan.wahren@i2se.com>
 <722dafcb-2f67-88c7-69df-d442c56c058f@synopsys.com>
Message-ID: <263309088.290419.51598113-17aa-4db0-9dc0-6e58e3fafe07.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

> John Youn <John.Youn@synopsys.com> hat am 16. August 2016 um 21:30
> geschrieben:
> 
> 
> On 7/26/2016 11:54 AM, Stefan Wahren wrote:
> ...
> > +/*
> > + * Settings for otg
> > + *
> > +	dr_mode = "otg";
> > +	h-rx-fifo-size = <774>;
> > +	h-np-tx-fifo-size = <32>;
> > +	h-tx-fifo-size = <0>;
> 
> This seems odd. It should be non-zero for use when operating as host.
> 

like in host mode i took the default values in otg mode for the last two here
(please refer to the logs). The BCM2835 datasheet isn't very helpful.

Do you have any suggestions for valid values or how to get them?
