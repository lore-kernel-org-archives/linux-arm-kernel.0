From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 23 Dec 2013 15:24:26 +0530
Subject: [PATCH V7 0/8] ARM: OMAP3+: support cpufreq-cpu0 for device tree
 boot
In-Reply-To: <1381937948-27057-1-git-send-email-nm@ti.com>
References: <1381937948-27057-1-git-send-email-nm@ti.com>
Message-ID: <CAOh2x==pT=ASrocV=dRKgFECyWbxN3pnzo9a4026szPGLXfbqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 9:09 PM, Nishanth Menon <nm@ti.com> wrote:
> PandaBoard-ES (OMAP4460): http://pastebin.com/qQCmA2ng

Hi Nishanth,

A colleague of mine (Sanjay), was trying mainline on panda board. And
wasn't able to get cpufreq-cpu0 working with it. Even your log also
reports its broken as it can't get any regulator information..

He is getting this:

cpufreq_cpu0: failed to get cpu0 regulator: -19
cpufreq_cpu0: failed to get cpu0 clock: -2
cpufreq-cpu0: probe of cpufreq-cpu0.0 failed with error -2

Can you please help him out?

--
viresh
