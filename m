From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 23 Oct 2013 19:10:41 +0530
Subject: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
In-Reply-To: <1382533461-31021-1-git-send-email-andrew@lunn.ch>
References: <1382533461-31021-1-git-send-email-andrew@lunn.ch>
Message-ID: <CAKohpombg7mAmgxxvUg8kz1MaFwcycR1eL0UrgELY2WdGfrAag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 October 2013 18:34, Andrew Lunn <andrew@lunn.ch> wrote:
> The Marvell Dove SoC can run the CPU at two frequencies. The high
> frequencey is from a PLL, while the lower is the same as the DDR
> clock. Add a cpufreq driver to swap between these frequences.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Sort header files
> Comment the interrupt handler

Really? I don't see these two comments being incorporated..
Also, you would be required to update your patchset ones my
patches are in (And that will happen for v3.13)..
