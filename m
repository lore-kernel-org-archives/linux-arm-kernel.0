From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 1 Nov 2013 05:16:30 +0530
Subject: [PATCH v3 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
In-Reply-To: <1383247111-26834-1-git-send-email-andrew@lunn.ch>
References: <1383247111-26834-1-git-send-email-andrew@lunn.ch>
Message-ID: <CAKohpo=m1SR3mJoFuGzQRW5-AWSujtMYZ7V3-_LyRn5WoTCcuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 November 2013 00:48, Andrew Lunn <andrew@lunn.ch> wrote:
> The Marvell Dove SoC can run the CPU at two frequencies. The high
> frequencey is from a PLL, while the lower is the same as the DDR
> clock. Add a cpufreq driver to swap between these frequences.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

As I have said early, you need to rebase this now over linux-next, which
has got over 150 patches for cpufreq for 3.13..

Over that following patchset would be included in linux-next as soon as
3.13-rc1 or rc2 is going to be released and so probably before your
patch makes it:

https://lkml.org/lkml/2013/10/30/553

So, please rebase your driver over linux-next & above patchset and
resend again..
