From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 3 Oct 2012 15:29:14 +0100
Subject: [PATCH 1/3] Revert "spi/pl022: fix spi-pl022 pm enable at probe"
In-Reply-To: <CAPDyKFrQ9UhEc_jEKdR=J8T-NUxsYQHB-yMh2vTyxJ+y+R38Og@mail.gmail.com>
References: <1348831266-16721-1-git-send-email-ulf.hansson@stericsson.com>
 <1348831266-16721-2-git-send-email-ulf.hansson@stericsson.com>
 <CAPDyKFo5-UeUe7PkxCBMnRziWh+eSC_ZjJ0pKhcBkHUkFdSH+w@mail.gmail.com>
 <20121003135556.GE4360@opensource.wolfsonmicro.com>
 <CAPDyKFrQ9UhEc_jEKdR=J8T-NUxsYQHB-yMh2vTyxJ+y+R38Og@mail.gmail.com>
Message-ID: <20121003142913.GF4360@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2012 at 04:28:34PM +0200, Ulf Hansson wrote:

> I will do a resend and include some explanation for the reverts in the
> "cover-letter".

It'd be good if the explanation could be in the commit logs so that
people reading history can understand things.
