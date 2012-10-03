From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 3 Oct 2012 16:28:34 +0200
Subject: [PATCH 1/3] Revert "spi/pl022: fix spi-pl022 pm enable at probe"
In-Reply-To: <20121003135556.GE4360@opensource.wolfsonmicro.com>
References: <1348831266-16721-1-git-send-email-ulf.hansson@stericsson.com>
 <1348831266-16721-2-git-send-email-ulf.hansson@stericsson.com>
 <CAPDyKFo5-UeUe7PkxCBMnRziWh+eSC_ZjJ0pKhcBkHUkFdSH+w@mail.gmail.com>
 <20121003135556.GE4360@opensource.wolfsonmicro.com>
Message-ID: <CAPDyKFrQ9UhEc_jEKdR=J8T-NUxsYQHB-yMh2vTyxJ+y+R38Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

I will do a resend and include some explanation for the reverts in the
"cover-letter".

Kind regards
Ulf Hansson

On 3 October 2012 15:55, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Oct 03, 2012 at 03:43:16PM +0200, Ulf Hansson wrote:
>
>> Heard from Linus Walleij that you Mark has been helping out merging
>> spi patches, did not know that when sending out this series. Anyway,
>> do you guys see any issues merging this?
>
>> [PATCH 1/3] Revert "spi/pl022: fix spi-pl022 pm enable at probe"
>> [PATCH 2/3] Revert "spi/pl022: enable runtime PM"
>> [PATCH 3/3] spi: spi-pl022: Minor simplification for runtime pm
>
> If someone could send the patches I'll take a look...  some explanation
> as to why we're reverting things would be helpful.
