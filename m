From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 21 Aug 2015 17:55:38 +0200
Subject: [PATCH] ARM: orion5x: fix legacy orion5x IRQ numbers
In-Reply-To: <1440156836.5070.9.camel@dolka.fr>
References: <1439648246-32757-1-git-send-email-gregory.clement@free-electrons.com>
 <1440156836.5070.9.camel@dolka.fr>
Message-ID: <55D749FA.6010600@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin,

On 21/08/2015 13:33, Benjamin Cama wrote:
> Hi Gr?gory,
> 
> Le samedi 15 ao?t 2015 ? 16:17 +0200, Gregory CLEMENT a ?crit :
>> I amended the patch from Benjamin as it break the build for
>> dove. Could you test it again wit this version?
> 
> Thanks for the fix. I don't have much time to test it, but as the dts
> conversion patch for my Linkstation Mini is in the series, this fix
> shouldn't change anything, as the dts board file uses the generic
> irqchip handler, isn't it?
> 
> Tell me if I missed something. Regards,

Detlef tested it so it's OK. I was asking you also because it a patch
you wrote.


Thanks,

Gregory


> --
> benjamin
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
