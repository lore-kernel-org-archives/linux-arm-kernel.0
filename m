From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 3 Oct 2012 14:55:57 +0100
Subject: [PATCH 1/3] Revert "spi/pl022: fix spi-pl022 pm enable at probe"
In-Reply-To: <CAPDyKFo5-UeUe7PkxCBMnRziWh+eSC_ZjJ0pKhcBkHUkFdSH+w@mail.gmail.com>
References: <1348831266-16721-1-git-send-email-ulf.hansson@stericsson.com>
 <1348831266-16721-2-git-send-email-ulf.hansson@stericsson.com>
 <CAPDyKFo5-UeUe7PkxCBMnRziWh+eSC_ZjJ0pKhcBkHUkFdSH+w@mail.gmail.com>
Message-ID: <20121003135556.GE4360@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2012 at 03:43:16PM +0200, Ulf Hansson wrote:

> Heard from Linus Walleij that you Mark has been helping out merging
> spi patches, did not know that when sending out this series. Anyway,
> do you guys see any issues merging this?

> [PATCH 1/3] Revert "spi/pl022: fix spi-pl022 pm enable at probe"
> [PATCH 2/3] Revert "spi/pl022: enable runtime PM"
> [PATCH 3/3] spi: spi-pl022: Minor simplification for runtime pm

If someone could send the patches I'll take a look...  some explanation
as to why we're reverting things would be helpful.
