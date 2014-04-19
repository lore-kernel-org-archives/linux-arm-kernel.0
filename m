From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Sat, 19 Apr 2014 22:43:20 +0900
Subject: [PATCH 0/2] Support cpufreq driver for Exynos3250
In-Reply-To: <CAK9yfHygoHZ7hnAcLuuaMEsPb8Tqw-QbcTrQ+b=2CD6kK3odmw@mail.gmail.com>
References: <1397787634-9334-1-git-send-email-cw00.choi@samsung.com>
 <CAK9yfHygoHZ7hnAcLuuaMEsPb8Tqw-QbcTrQ+b=2CD6kK3odmw@mail.gmail.com>
Message-ID: <CAGTfZH1M9h3Sx73wJsD=_vnSyV-+fyOY041PN_7ea718B0mFoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sachin,

On Fri, Apr 18, 2014 at 5:14 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Hi Chanwoo,
>
> On 18 April 2014 07:50, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> This patchset support cpufreq driver for Exynos3250 which uses the Cortex-A7
>> dual cores and has a target speed of 1.0 GHz and code clean using dev_err/info
>> instead of pr_err/info function.
>
> Per SoC cpufreq driver which does not use CCF is no more encouraged for new
> Exynos platforms. Thomas has already posted patches to make use of
> generic cpu freq driver
> on Exynos platforms. Please refer to [1] and try to utilize it for
> this platform as well.
>
> [1] http://permalink.gmane.org/gmane.linux.kernel.samsung-soc/26886

OK, I'll refer to this new patch for cpufreq and rebase it.

Thanks for your reply.

Best Regards,
Chanwoo Choi
