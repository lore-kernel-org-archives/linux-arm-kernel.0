From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 1 Nov 2013 05:22:21 +0530
Subject: [PATCH v3 3/4] mvebu: Dove: Enable cpufreq driver in defconfig
In-Reply-To: <1383247111-26834-3-git-send-email-andrew@lunn.ch>
References: <1383247111-26834-1-git-send-email-andrew@lunn.ch>
 <1383247111-26834-3-git-send-email-andrew@lunn.ch>
Message-ID: <CAKohpomOpfg3+OVooum9jVK2H12bu1Nz=zPMFWF02sCh6MdUhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 November 2013 00:48, Andrew Lunn <andrew@lunn.ch> wrote:
> Add cpufreq to dove_defconfig, so it is built by default.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
>  arch/arm/configs/dove_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
