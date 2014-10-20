From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 20 Oct 2014 13:35:38 +0200
Subject: [PATCH v11 0/6] cpufreq: use generic cpufreq drivers for exynos
 platforms
In-Reply-To: <1413805281-6269-1-git-send-email-thomas.ab@samsung.com>
References: <1413805281-6269-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <5444F38A.1000101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.10.2014 13:41, Thomas Abraham wrote:
> Changes since v10:
> - Rebased on top of v3.18-rc1
> 
> This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
> drivers and enables the use of cpufreq-dt driver for these platforms. This
> series also enables cpufreq support for Exynos5420 using arm_big_little cpufreq
> driver.
> 
> This patch series is based and tested on v3.18-rc1 and depends on the patch
> - "clk: exynos4: remove duplicate div_core2 divider clock instantiation"
>   (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34859.html)
>   This patch has been merged in "arm-soc/samsung/dt3" branch of arm-soc tree.
> 

That patch actually went through clock tree, but it doesn't matter,
because AFAIK all the dependencies for this series are already in
3.18-rc1. I'll try to apply it in next days

Best regards,
Tomasz
