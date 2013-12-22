From: olof@lixom.net (Olof Johansson)
Date: Sun, 22 Dec 2013 11:44:18 -0800
Subject: [GIT PULL] at91: drivers for 3.14 #1
In-Reply-To: <1386925545-10495-1-git-send-email-nicolas.ferre@atmel.com>
References: <1386925545-10495-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20131222194418.GC9144@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 13, 2013 at 10:05:45AM +0100, Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> This is a "drivers" series that adds Device Tree support to 
> Atmel crypto drivers (AES/[T]DES/SHA). As the DT part of this
> addition is in at91-3.14-dt I thought it would be simpler to take
> this series through arm-soc. I asked and got Herbert's blessing.
> 
> The Device Tree entries documented in these patches are very simple
> and only declare the reg/irq values and the link to DMA.
> 
> Thanks, best regards,
> 
> The following changes since commit b46e837d8ef1f3c777bbf9513e2cdb5d87d6c374:
> 
>   ARM: at91/dt: remove old clk material (2013-12-02 15:31:29 +0100)
> 
> are available in the git repository at:
> 
>   git://github.com/at91linux/linux-at91.git tags/at91-drivers
> 
> for you to fetch changes up to 1ca5b7d95315c42cf0b78d33cd316e404a9f137c:
> 
>   crypto: atmel-sha - add sha information to the log (2013-12-12 18:39:36 +0100)
> 
> ----------------------------------------------------------------
> AT91 crypto drivers DT support:
> - add DT to sha/des/aes existing drivers
> - add DMA DT
> - all documentation added to crypto/atmel-crypto.txt file
> 
> ----------------------------------------------------------------
> Nicolas Ferre (4):
>       crypto: atmel-aes - add support for Device Tree
>       crypto: atmel-tdes - add support for Device Tree
>       crypto: atmel-sha - add support for Device Tree
>       crypto: atmel-sha - add sha information to the log

Pulled. In the future make sure to cc binding changes to
devicetree at vger.kernel.org for review. These bindings all seemed to be
trivial though so I merged anyway.


-Olof
