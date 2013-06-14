From: abrestic@google.com (Andrew Bresticker)
Date: Fri, 14 Jun 2013 10:26:57 -0700
Subject: [PATCH v2 06/10] clk: exynos5420: register clocks using common
 clock framework
In-Reply-To: <1371218572-8993-7-git-send-email-chander.kashyap@linaro.org>
References: <1370516488-25860-10-git-send-email-chander.kashyap@linaro.org>
 <1371218572-8993-1-git-send-email-chander.kashyap@linaro.org>
 <1371218572-8993-7-git-send-email-chander.kashyap@linaro.org>
Message-ID: <CAL1qeaFS=MMHJj8TP4vX8-KeXNo0W_EjvhrLsb5=YNsnaqOVXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chander,

> +       [Core Clocks]
> +
> +  Clock                        ID
> +  ----------------------------
> +
> +  oscclk               1

I know the UM refers to this as 'oscclk', but could we instead call
this 'fin_pll' to be consistent with Exynos 4 and Exynos 5250?

Thanks,
Andrew
