From: hisao.munakata.vt@renesas.com (hisao munakata)
Date: Fri, 13 Aug 2010 19:52:47 +0900
Subject: [regression] in linux-next: sh_mobile_ceu_camera broken by
	"ARM: Prohibit ioremap() on kernel managed RAM"
In-Reply-To: <20100810212638.GC7702@n2100.arm.linux.org.uk>
References: <4C5ED116.5000002@arndnet.de>
	<201008101045.03547.philippe.retornaz@epfl.ch>
	<20100810092759.GB31759@n2100.arm.linux.org.uk>
	<Pine.LNX.4.64.1008102117000.18934@axis700.grange>
	<20100810212638.GC7702@n2100.arm.linux.org.uk>
Message-ID: <20100813195247.5ac300c7.hisao.munakata.vt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell

This is Munakata of Renesas. I am a kind of manager and not a kernel 
developer. So I wonder this message may not include any topic interest for you, 
Initially I want to express my great appreciation for your help to add Renesas 
SH-Mobile series kernel support. Actually majority of patches to support 
SH-Mobile series are written by Renesas Linux development team colleagues 
like Magnus, Guennadi, Arnd and others those are working in my team.

As you may know, we used to develop SuperH CPU support with the
help of SuperH maintainer Paul.  Now he also works inside my team. 
That means CPU architecture provider, chip vendor and community 
kernel maintainer are working at the same place.  And luckily or unluckily
there are not so many relevant party around SuperH.  Now I am getting
to learn ARM development requires much much tough coordination work
against various instruction set, each chip implementations and others. 

I am not sure how can I make this happen, but Renesas want to
help your work if possible.  At least I do not want to have our
private kernel tree out side community master repository. So
I try to submit all required patches including ARM core part code
from now on. Is that OK for you ?

If you have any request for us as a chip vendor and community
developer, please kindly tell me your thought. I am planing to
attend CE Linux Forum ELCE (Embedded Linux conference Europe)
hold at Cambridge UK this fall ( October 27th and 28th). If we can 
have a chance to discuss this kind of topic around then, that
will be really great.

-- 
hisao munakata <hisao,munakata.vt@renesas.com>
Executive manager 
System Business Div.
Renesas Solutions Corp.
