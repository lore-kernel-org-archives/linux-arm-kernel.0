From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Sun, 24 Aug 2014 23:35:38 +0530
Subject: [PATCH] ARM: debug: uncompress debug support for omap2plus
In-Reply-To: <1407922264-6214-1-git-send-email-kpark3469@gmail.com>
References: <1407922264-6214-1-git-send-email-kpark3469@gmail.com>
Message-ID: <20140824180538.GA15186@afzal-ThinkPad-R50e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Tony

Hi,

On Wed, Aug 13, 2014 at 06:31:04PM +0900, kpark3469 at gmail.com wrote:

> Since OMAP low-level debug code places data in the .data section,
> The symbol DEBUG_UNCOMPRESS was defined with !DEBUG_OMAP2PLUS_UART.
> This patch removes the part using data section in debug/omap2plus.S,
> so DEBUG_UNCOMPRESS is now available on OMAP system.

Tested-by: Afzal Mohammed <afzal.mohd.ma@gmail.com> (on am335x beagle
bone white)

Regards
Afzal
