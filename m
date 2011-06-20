From: jj@chaosbits.net (Jesper Juhl)
Date: Mon, 20 Jun 2011 12:34:37 +0200 (CEST)
Subject: [PATCH][Trivial] S3C2410 bluetooth: Remove duplicate linux/leds.h
	include
In-Reply-To: <4DFF1AA5.80508@ru.mvista.com>
References: <alpine.LNX.2.00.1106201035590.18991@swampdragon.chaosbits.net>
	<4DFF1AA5.80508@ru.mvista.com>
Message-ID: <alpine.LNX.2.00.1106201232530.18991@swampdragon.chaosbits.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Jun 2011, Sergei Shtylyov wrote:

> Hello.
> 
> On 20-06-2011 12:40, Jesper Juhl wrote:
> 
> > Remove the duplicate inclusion of linux/leds.h from
> > arch/arm/mach-s3c2410/h1940-bluetooth.c that was added by commit 50e2d10d.
> 
>    Pelase also specify that commit's summary in parens.
> 

Anyone can just do a "git show 50e2d10d" to read it. But sure, here's a 
new patch description:

Remove the duplicate inclusion of linux/leds.h from 
arch/arm/mach-s3c2410/h1940-bluetooth.c that was added by commit 50e2d10d 
(ARM: S3C2410: H1940: Use leds-gpio driver for LEDs managing).


> > Signed-off-by: Jesper Juhl<jj@chaosbits.net>
> 
> WBR, Sergei
> 

-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
