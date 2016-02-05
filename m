From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Fri, 5 Feb 2016 16:43:54 +0200
Subject: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
In-Reply-To: <20160205061021.GS19432@atomide.com>
References: <20160108022619.GS12777@atomide.com> <568F4596.8020206@gmail.com>
 <20160108075913.GN11364@pali> <569052FE.1040008@gmail.com>
 <20160121091437.GT7192@pali> <56B077D4.3030902@gmail.com>
 <20160202233911.GB19432@atomide.com> <20160203000045.GE19432@atomide.com>
 <56B1A654.1060905@gmail.com> <56B22FC3.3050900@gmail.com>
 <20160205061021.GS19432@atomide.com>
Message-ID: <56B4B52A.4060102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On  5.02.2016 08:10, Tony Lindgren wrote:

> This seems to fix things here for legacy booting and booting the
> maemo zImage after dts image. Care to give it a try?
>
> Basically onenand after reset is in wrong state, have not looked
> up the bits yet. Will post a better patch when I get a chance
> over next few days.
>
> Regards,
>
> Tony

Yep, that looks to fix the things, I submitted a patch "[PATCH] ARM: 
OMAP2+: Fix onenand initialization to avoid filesystem corruption" (it 
was supposed to be a reply to this mail, but my git-send-mail-fu failed 
on me as always :) )

Thanks,
Ivo
