From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 16 Jul 2010 22:39:32 +0900
Subject: [PATCH 0/3] Add support I2C devices on SMDK6440, SMDKC110 and
	SMDKV210
In-Reply-To: <1279285999-27555-1-git-send-email-kgene.kim@samsung.com>
References: <1279285999-27555-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <AANLkTinRtiRcfTteZR-OkmLpL1oSpEmsKf0MWDj89AUH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maybe it requires the s5pc210(s5pv310) support also.
As you know s5pc210 has 8 I2Cs. the problem is that current
implementation need each i2c device gpio setup and Kconfig
Do you think it's reasonable?

I think we need to find a good way to solve this issue. do you have any idea?

Thank you,
Kyungmin Park

On Fri, Jul 16, 2010 at 10:13 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> This patches is to support I2C devices on SMDK6440, SMDKC110 and SMDKV210.
> S5P6440 can support I2C channel 0 and 1, and S5PV210/S5PC110 can support
> I2C channel 0, 1 and 2.
>
> [PATCH 1/3] ARM: S5P6440: Add support for I2C channel 0 and 1 on SMDK6440
> [PATCH 2/3] ARM: S5PV210: Add support for I2C devices on SMDKV210 and SMDKC110
> [PATCH 3/3] i2c/busses: Select I2C bus support for S5PV210 and S5P6440.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
