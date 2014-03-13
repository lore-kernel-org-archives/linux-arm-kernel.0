From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 13 Mar 2014 08:25:43 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSHYxNF1bIDQvNF0gQVJNOiBkdHM6IGlteDI1OiBtYmlteHNk?=
 =?UTF-8?B?MjU6IEFkZCBkaXNwbGF5cyBzdXBwb3J0Lg==?=
In-Reply-To: <CAOMZO5Cxvc3-brgKNCq8RXsjcj==7Ne+avgT_EVXrAAFSVDmUg@mail.gmail.com>
References: <1390410577-22073-1-git-send-email-denis@eukrea.com>
 <20140312220756.02f5b006@e6520eb>
 <CAOMZO5Cxvc3-brgKNCq8RXsjcj==7Ne+avgT_EVXrAAFSVDmUg@mail.gmail.com>
Message-ID: <1394684743.193831485@f438.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?????, 12 ????? 2014, 18:16 -03:00 ?? Fabio Estevam <festevam@gmail.com>:
> Hi Eric,
> 
> On Wed, Mar 12, 2014 at 6:07 PM, Eric B?nard <eric@eukrea.com> wrote:
> 
> > if you have an oscilloscope, can you probe PIXCLK, HSYNC, VSYNC and DE
> > to check the signals are properly configured vs the datasheet of your
> > display.
> 
> Yes, I have measured VSYNC and there is no activity on this line.
> 
> Also tried 3.13 with a non-dt kernel and the same issue is seen.
> 
> Running FSL 2.6.31 I can see VSYNC at 57Hz and Tux on the display, so
> the hardware is good.
> 
> At least for me imxfb seems to be broken even for the non-dt case.

I will check the latest changes on the weekends for i.MX27.

---
