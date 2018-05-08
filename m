From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 8 May 2018 15:19:14 +0200
Subject: [PATCH v9 00/12] Sunxi: Add SMP support on A83T
In-Reply-To: <20180504190545.5114-1-mylene.josserand@bootlin.com>
References: <20180504190545.5114-1-mylene.josserand@bootlin.com>
Message-ID: <20180508131914.6sy7cd6urnfg3tam@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 04, 2018 at 09:05:33PM +0200, Myl?ne Josserand wrote:
> Hello everyone,
> 
> This is a V9 of my series that adds SMP support for Allwinner sun8i-a83t.
> Based on sunxi's tree, sunxi/for-next branch.
> Depends on a patch from Doug Berger that allows to include the "cpu-type"
> header on assembly files that I included in my series (patch 01).

I applied the patches, with the remarks done by Russell on v8 fixed,
and the function sun8i_a83t_cntvoff_init made static.

> The difference with the v8 is just that the machine is renamed in sun8i-a83t
> (see patch 07), according to Maxime's review.

The machine name hasn't changed, and the name sun8i-a83t still doesn't
make much sense. I've fixed it as well.

Thanks,
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
