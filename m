From: b32955@freescale.com (Huang Shijie)
Date: Mon, 21 May 2012 10:44:55 +0800
Subject: [PATCH 1/4] GPMI-NAND: Define ecc.strength
In-Reply-To: <20120521014121.GO5427@S2101-09.ap.freescale.net>
References: <1337562140-5739-1-git-send-email-marex@denx.de>
 <20120521011455.GL5427@S2101-09.ap.freescale.net>
 <201205210336.41860.marex@denx.de>
 <20120521014121.GO5427@S2101-09.ap.freescale.net>
Message-ID: <4FB9AC27.2050207@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek:
> On Mon, May 21, 2012 at 03:36:41AM +0200, Marek Vasut wrote:
>> Dear Shawn Guo,
>>
>>> So non-DT probe has the same issue?  Or this is a DT probe only issue?
>> I started using DT, so I'm now fixing everything to work like it used to. Damn
>> this DT conversion broke about everything.
>>
> So you are saying the issue is introduced by gpmi-nand DT conversion?
>
thanks for your work. :)
But the gpmi nand driver should not work right now.

The DT for gpmi-nand is in Artem's l2-mtd tree.
And the device node item in DTS for gpmi is not added now.( I ever 
submitted, but not accepted.)
Also the pinctrl item for gpmi is also not added not.

So I suggest you test it again when the next merge window opens, and all 
the code is merged to kernel.
If the bug still exits, please submit a fix patch then.

By the way, I really did not meet your error when I test the DT patches 
for gpmi.

thanks
Huang Shijie
