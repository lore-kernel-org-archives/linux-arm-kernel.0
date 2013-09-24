From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 24 Sep 2013 21:19:42 +0200
Subject: [PATCH v2] ARM: SAMSUNG: S5P: If detected device tree skip irq
 init
In-Reply-To: <1380038363-487-1-git-send-email-m.krawczuk@partner.samsung.com>
References: <1380038363-487-1-git-send-email-m.krawczuk@partner.samsung.com>
Message-ID: <2123658.6S6hP57GRg@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mateusz,

On Tuesday 24 of September 2013 17:59:23 Mateusz Krawczuk wrote:
> It prevents from executing things already handled by pinctrl-exynos
> driver, when device tree is available.
> 
> Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-samsung/s5p-irq-eint.c | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Tomasz Figa <t.figa@samsung.com>

[as a temporary solution until we move all the users of this code to 
device tree]

Best regards,
Tomasz
