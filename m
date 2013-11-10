From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 10 Nov 2013 18:08:01 +0100
Subject: [PATCH 2/3] clk: exynos5250: fix sysmmu_mfc{l,r} gate clocks
In-Reply-To: <1383905648-23733-2-git-send-email-sachin.kamat@linaro.org>
References: <1383905648-23733-1-git-send-email-sachin.kamat@linaro.org>
 <1383905648-23733-2-git-send-email-sachin.kamat@linaro.org>
Message-ID: <2996623.YXg5JqReYS@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sachin, Andrew,

On Friday 08 of November 2013 15:44:07 Sachin Kamat wrote:
> From: Andrew Bresticker <abrestic@chromium.org>
> 
> The gate clocks for the MFC sysmmus appear to be flipped, i.e.
> GATE_IP_MFC[2] gates sysmmu_mfcl and GATE_IP_MFC[1] gates sysmmu_mfcr.
> Fix this so that the MFC will start up.

Wow, this means that there is a mistake in the documentation. Not that
I'm surprised, though.

I guess you are sure about this, so:

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
