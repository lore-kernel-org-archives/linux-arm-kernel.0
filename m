From: horms@verge.net.au (Simon Horman)
Date: Fri, 28 Jun 2013 17:26:25 +0900
Subject: [PATCH 1/3] ARM: shmobile: r8a73a4: add clocks for I2C controllers
In-Reply-To: <1372326479-15028-2-git-send-email-g.liakhovetski@gmx.de>
References: <1372326479-15028-1-git-send-email-g.liakhovetski@gmx.de>
 <1372326479-15028-2-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <20130628082624.GB29517@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 11:47:56AM +0200, Guennadi Liakhovetski wrote:
> r8a73a4 SoCs have numerous I2C controllers, of which 9 are compatible with
> the i2c-sh_mobile.c driver. This patch adds clock definitions for them.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/clock-r8a73a4.c |   25 +++++++++++++++++++++++--
>  1 files changed, 23 insertions(+), 2 deletions(-)

Thanks, queued-up for v3.12 in the soc branch.
