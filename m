From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Aug 2015 18:28:48 -0700
Subject: [PATCH v2] ARM: dts: UniPhier: fix PPI interrupt CPU mask of
 timer nodes
In-Reply-To: <1439963366-4848-1-git-send-email-yamada.masahiro@socionext.com>
References: <1439963366-4848-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20150821012848.GA4865@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 02:49:26PM +0900, Masahiro Yamada wrote:
> This SoC is integrated with 4 Cortex-A9 cores.  The GIC bindings
> document says that the bits[15:8] of the 3rd cell of the interrupts
> property represents PPI interrupt CPU mask.  Because the timer
> interrupts are wired to all of the 4 cores, bits[15:8] should be set
> to 0xf.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Fix git-description

Thanks, applied.


-Olof
