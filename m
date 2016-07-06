From: olof@lixom.net (Olof Johansson)
Date: Tue, 5 Jul 2016 22:11:29 -0700
Subject: [RESEND PATCH] ARM: oxnas: Change OX810SE default driver config
In-Reply-To: <577392EF.7030609@baylibre.com>
References: <577392EF.7030609@baylibre.com>
Message-ID: <20160706051129.GJ23212@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 11:20:47AM +0200, Neil Armstrong wrote:
> Since the SP804 timer changes will not been merged upstream, switch the
> default OX810SE config to the OXNAS RPS Timer driver configuration.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/mach-oxnas/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Dear arm-soc maintainers,
> 
> Gentle ping/resend about this patch, it would be great to see it in 4.8 !
> 
> Daniel just accepted my patchset at :
> http://lkml.kernel.org/r/1465985607-21231-1-git-send-email-narmstrong at baylibre.com
> 
> And now the default config can be switched to OXNAS_RPS_TIMER without any
> device tree changes.

Applied manually, and inserted the new option where it belongs alphabetically
in the list.


-Olof
