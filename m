From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 3 Aug 2013 14:16:48 -0400
Subject: [PATCH] leds: leds-ns2: depends on ARCH_KIRKWOOD
In-Reply-To: <1375454798-6849-1-git-send-email-simon.guinot@sequanux.org>
References: <1375369655-1310-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375454798-6849-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20130803181648.GF13555@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 04:46:38PM +0200, Simon Guinot wrote:
> With the DT conversion, the board Kconfig symbols MACH_ are going to be
> removed. In order to prepare this removal, this patch replaces alls the
> machines dependencies for leds-ns2 by ARCH_KIRKWOOD.
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> ---
> Thomas,
> 
> Please, insert this patch in your series before the patch named:
> [PATCHv2 1/9] ARM: kirkwood: convert d2net_v2 to DT
> 
> Simon
> 
>  drivers/leds/Kconfig |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Almost missed this one.  This should also go through -leds.

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
