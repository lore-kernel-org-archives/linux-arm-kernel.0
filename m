From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Oct 2013 11:27:54 -0700
Subject: [PATCH] ARM: omap1: fix incorrect placement of __initdata tag
In-Reply-To: <1861324.5ZgdrbcBQI@amdc1032>
References: <1861324.5ZgdrbcBQI@amdc1032>
Message-ID: <20131003182754.GU8949@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> [130930 06:13]:
> __initdata tag should be placed between the variable name and equal
> sign for the variable to be placed in the intended .init.data section.

Thanks applying into omap-for-v3.13/fixes-not-urgent.

Tony
