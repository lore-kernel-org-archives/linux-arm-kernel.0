From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 22 Dec 2014 16:08:26 +0100
Subject: [PATCH 3/4] clk: samsung: exynos7: add clocks for audio block
In-Reply-To: <1418995427-7712-4-git-send-email-padma.v@samsung.com>
References: <1418995427-7712-1-git-send-email-padma.v@samsung.com>
 <1418995427-7712-4-git-send-email-padma.v@samsung.com>
Message-ID: <549833EA.8040506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 19/12/14 14:23, Padmavathi Venna wrote:
> Add required clk support for I2S,PCM amd SPDIF

There is a non-trivial conflict with the MSCL CMU patch, could you
please resend rebased onto my exynos7 branch:

git://linuxtv.org/snawrocki/samsung.git for-v3.20/clk/exynos7 ?

Is exynos7420 documentation applicable to this ?
Would be nice to have someone else who has access to the SoC
documentation replied with a Reviewed-by tag.

-- 
Thanks,
Sylwester
