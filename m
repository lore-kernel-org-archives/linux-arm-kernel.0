From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri, 18 Apr 2014 13:44:49 +0530
Subject: [PATCH 0/2] Support cpufreq driver for Exynos3250
In-Reply-To: <1397787634-9334-1-git-send-email-cw00.choi@samsung.com>
References: <1397787634-9334-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <CAK9yfHygoHZ7hnAcLuuaMEsPb8Tqw-QbcTrQ+b=2CD6kK3odmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On 18 April 2014 07:50, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patchset support cpufreq driver for Exynos3250 which uses the Cortex-A7
> dual cores and has a target speed of 1.0 GHz and code clean using dev_err/info
> instead of pr_err/info function.

Per SoC cpufreq driver which does not use CCF is no more encouraged for new
Exynos platforms. Thomas has already posted patches to make use of
generic cpu freq driver
on Exynos platforms. Please refer to [1] and try to utilize it for
this platform as well.

[1] http://permalink.gmane.org/gmane.linux.kernel.samsung-soc/26886

-- 
With warm regards,
Sachin
