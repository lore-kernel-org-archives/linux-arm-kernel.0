From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 24 Sep 2013 17:06:31 +0200
Subject: [PATCH] pinctrl: Correct number of pins for s5pv210
In-Reply-To: <1380035051-24526-1-git-send-email-m.krawczuk@partner.samsung.com>
References: <1380035051-24526-1-git-send-email-m.krawczuk@partner.samsung.com>
Message-ID: <2660734.r2Dp8L0F5K@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mateusz,

On Tuesday 24 of September 2013 16:35:07 Mateusz Krawczuk wrote:
> Values of pins in table s5pv210 bank are incorrect. This patch correct values.
> 
> Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/pinctrl/pinctrl-exynos.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Acked-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz

P.S. Please be more careful next time when defining things like this.
