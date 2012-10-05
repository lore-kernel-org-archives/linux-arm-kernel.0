From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 5 Oct 2012 13:23:04 +0100
Subject: [PATCH V2 1/3] Revert "spi/pl022: fix spi-pl022 pm enable at
 probe"
In-Reply-To: <1349337881-15917-2-git-send-email-ulf.hansson@stericsson.com>
References: <1349337881-15917-1-git-send-email-ulf.hansson@stericsson.com>
 <1349337881-15917-2-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20121005122303.GB4360@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2012 at 10:04:39AM +0200, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> This reverts commit 6887237cd7da904184dab2750504040c68f3a080.
> 
> This reverts is done due to earlier wrong commit, which is
> also reverted. "Revert "spi/pl022: enable runtime PM""

Why?  "Wrong" isn't terribly detailed...
