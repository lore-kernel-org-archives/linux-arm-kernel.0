From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 18 Aug 2015 18:26:42 +0530
Subject: [PATCH v2 0/6] ARM: berlin: add cpufreq support
In-Reply-To: <1439898368-11543-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1439898368-11543-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <CAOh2x=ke9NWa-GjL=c+RgEWWfsNeKvE2O9CRHmW2dG5mj8ATCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 5:16 PM, Antoine Tenart
<antoine.tenart@free-electrons.com> wrote:
> Hi,
>
> This series adds the cpufreq support to the Berlin SoCs, using
> cpufreq-dt.
>
> First, the cpuclk clock is added to the BG2Q clock driver. This clock
> has a divider fixed to 1, so we use a fixed factor clock here.
>
> Then register a platform device for cpufreq-dt.
>
> I also added the OPP table definition in the BG2Q, BG2 and BG2CD device
> trees. When using a BG2Q, some bootloaders may update this table when
> booting (mine doesn't).

You can switch to OPP-v2 bindings if you want. Just have a look, they are
much more powerful.. Should be in linux-next/master.
