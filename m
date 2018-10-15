From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 15 Oct 2018 09:31:19 +0200
Subject: [PATCH v2 6/9] ASoC: sunxi: allow the sun8i-codec driver to be
 built on ARM64
In-Reply-To: <20181013165329.13363-7-anarsoul@gmail.com>
References: <20181013165329.13363-1-anarsoul@gmail.com>
 <20181013165329.13363-7-anarsoul@gmail.com>
Message-ID: <20181015073119.fgsixra3nw3aannd@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 13, 2018 at 09:53:26AM -0700, Vasily Khoruzhick wrote:
> Allwinner A64 uses the same digital codec part as in A33, so we need
> to build this driver on ARM64 as well.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
