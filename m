From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 25 Sep 2014 12:14:16 +0200
Subject: [PATCH] ARM: efm32: drop selecting NO_DMA
In-Reply-To: <1411585151.19525.29.camel@x220>
References: <1411585151.19525.29.camel@x220>
Message-ID: <1411640056.7866.5.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-09-24 at 20:59 +0200, Paul Bolle wrote:
> Actually, the only difference I found in the .config file was that after
> this patch the .config file contained
>     CONFIG_ARCH_EFM32=y
> 
> I have no idea why. Did I botch my test?

Apparently I did. I retested this patch using next-20140925. Now the
generated .config before and after applying this patch are identical. So
all's good: this select really is a nop.


Paul Bolle
