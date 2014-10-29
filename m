From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 29 Oct 2014 16:18:46 +0200
Subject: Nokia n900 problems in 3.18-rc1 (was Re: USB Ethernet gadget
 on Nokia n900)
In-Reply-To: <20141029140943.GX2542@atomide.com>
References: <20141019090107.GA19132@amd> <201410262222.39892@pali>
 <20141026215548.GA9004@amd> <201410262323.17891@pali>
 <20141027195209.GP2560@atomide.com> <20141027223114.GU2560@atomide.com>
 <20141028220450.GA27667@amd> <20141028221124.GT2542@atomide.com>
 <20141029084637.GA30662@amd> <20141029140943.GX2542@atomide.com>
Message-ID: <5450F746.4030901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/10/14 16:09, Tony Lindgren wrote:

>> omapfb reports problems, but seems to work ok:
>>
>> [    0.990386] omapfb omapfb: cannot parse default modes
>> [    1.004791] Console: switching to colour frame buffer device 100x30
>> [    1.073150] omapfb omapfb: using display 'lcd' mode 800x480
> 
> Tomi, is the default mode warning correct here?

omapfb warns that it couldn't parse kernel cmdline parameters
('omapfb.mode' parameter). I couldn't find in the thread what actual
parameters were used in this case.

Although I don't see why N900 would need any omapfb mode parameters in
the first place, as the LCD has just one mode...

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141029/9b4bd037/attachment.sig>
