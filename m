From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 1 Nov 2013 05:22:00 +0530
Subject: [PATCH v3 2/4] mvebu: Dove: Instantiate cpufreq driver.
In-Reply-To: <1383247111-26834-2-git-send-email-andrew@lunn.ch>
References: <1383247111-26834-1-git-send-email-andrew@lunn.ch>
 <1383247111-26834-2-git-send-email-andrew@lunn.ch>
Message-ID: <CAKohpo=Y30y=0COqYf-JP0W4MY7RTDx0yVEdehGHGucNw_kiGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 November 2013 00:48, Andrew Lunn <andrew@lunn.ch> wrote:
> Add a platform driver definition to instantiate the dove cpufreq
> driver. Also indicate the ARCH has cpufreq support, so allowing the
> cpufreq framework to be enabled.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
