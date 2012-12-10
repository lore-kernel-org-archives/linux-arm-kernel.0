From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 10 Dec 2012 20:49:11 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
In-Reply-To: <509F8D6B.5070504@compulab.co.il>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il>
 <509AD478.1050904@ti.com> <509B666F.6080507@compulab.co.il>
 <509BDAF5.1010703@ti.com>
 <79CD15C6BA57404B839C016229A409A83EB68589@DBDE01.ent.ti.com>
 <509BEE6D.9000902@ti.com>
 <alpine.DEB.2.00.1211081754390.20703@utopia.booyaka.com>
 <509BF525.80309@ti.com>
 <alpine.DEB.2.00.1211081809470.20703@utopia.booyaka.com>
 <509BFB4E.2090802@ti.com> <509F8D6B.5070504@compulab.co.il>
Message-ID: <alpine.DEB.2.00.1212102047170.1982@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 11 Nov 2012, Igor Grinberg wrote:

> Yep, but the /800 do not get you the 32768...
> and that makes the timer suck.
> Of course this can be dealt with in the clock subsystem
> (I remember Paul said that he will look into that), but it will take time.

It should be possible to implement this now that the CCF conversion is 
done.  Not sure if I'll be able to get to it soon, though.

Is there anyone out there at TI who is focused on AM3517/3505 upstream 
work?


- Paul
