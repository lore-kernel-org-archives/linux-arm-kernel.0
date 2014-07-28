From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jul 2014 15:11:02 +0200
Subject: [PATCH v5 0/8] enable Hisilicon HIX5HD2 SoC
In-Reply-To: <1406551883-26154-1-git-send-email-haojian.zhuang@linaro.org>
References: <1406551883-26154-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <6493871.xlAJItBgfy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 July 2014 20:51:15 Haojian Zhuang wrote:
> Changelog:
> v5:
>   * Use CPU_OF_DECLARE_METHOD().
>   * State "hisilicon,cpuctrl" in documents.
>   * Set PL310 L2 aux value in machine descriptor.
>   * Use enable-method property for smp in dts file.
>   * Move reset code from machine platform driver into power reset driver.
>   * Move HIP04 debug uart into another patch series.

Looks ok for the most part. I have a trivial comment on patch 8/8,
please correct that.

The comment on patch 7/8 is more severe. Depending on the hardware
requirements, this may end up being much harder to fix, but it
needs some discussion. Adding the values only for hi3620 in the
meantime should be ok.

	Arnd
