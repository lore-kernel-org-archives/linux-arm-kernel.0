From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 1 Feb 2013 21:10:41 +0530
Subject: [PATCH v4 1/3] cpufreq: kirkwood: Add a cpufreq driver for
 Marvell Kirkwood SoCs
In-Reply-To: <1359729096-15371-2-git-send-email-andrew@lunn.ch>
References: <1359729096-15371-1-git-send-email-andrew@lunn.ch>
 <1359729096-15371-2-git-send-email-andrew@lunn.ch>
Message-ID: <CAKohponBrABri_8haNZXZY51caLnswAkGdzEyhb0UMCiDpJzVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 February 2013 20:01, Andrew Lunn <andrew@lunn.ch> wrote:
> The Marvell Kirkwood SoCs have simple cpufreq support in hardware. The
> CPU can either use the a high speed cpu clock, or the slower DDR
> clock. Add a driver to swap between these two clock sources.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Jason Cooper <jason@lakedaemon.net>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
