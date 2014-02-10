From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 10 Feb 2014 10:38:34 -0800
Subject: [PATCH] ARM: multi_v7_defconfig: Select CONFIG_SOC_DRA7XX
In-Reply-To: <1391700571-31784-1-git-send-email-nm@ti.com> (Nishanth Menon's
 message of "Thu, 6 Feb 2014 09:29:31 -0600")
References: <1391700571-31784-1-git-send-email-nm@ti.com>
Message-ID: <7hlhxi95jp.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> Select CONFIG_SOC_DRA7XX so that we can boot dra7-evm.
> DRA7 family are A15 based processors that supports LPAE and an
> evolutionary update to the OMAP5 generation of processors.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>
> based on v3.13-rc1 kernel tag - tested on v3.14-rc1 and next-20140206

Applied to arm-soc/fixes for v3.14-rc.

Kevin
