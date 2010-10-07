From: yong.shen@linaro.org (Yong Shen)
Date: Thu, 7 Oct 2010 12:10:35 +0800
Subject: [PATCH] cpufreq for freescale mx51
In-Reply-To: <201010061315.58771.arnd@arndb.de>
References: <1286279904-4378-1-git-send-email-yong.shen@linaro.org>
	<201010051425.06523.arnd@arndb.de>
	<AANLkTin7N8g1KdkyJ5ZsaKp=vUfvrffzvK8j+Z78bU0P@mail.gmail.com>
	<201010061315.58771.arnd@arndb.de>
Message-ID: <AANLkTikD4J_T+wiikvhMWEEECNiWN3Ri_yJM0_SX++p7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I still disagree, but it's not important. IMHO most of the uses of
> __raw_readl should be converted to readl or readl_relaxed if you are
> worried about efficiency.
>
> The main difference between __raw_readl and readl_relaxed is that the
> endianess is well-defined on readl_relaxed.
>
>        Arnd
>

I agree with you about that. I will keep that in mind and also notice my
colleages this in our future development.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101007/133e8673/attachment-0001.html>
