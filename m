From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 14 May 2014 19:20:58 +0530
Subject: [PATCH v4 1/8] cpufreq: cpufreq-cpu0: allow use of optional boost
 mode frequencies
In-Reply-To: <CAJuA9ajtCAGpBkSBH64bpTAbZKqPHTiDBFspuoXE1MSLyOyRPw@mail.gmail.com>
References: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
 <1400029876-5830-2-git-send-email-thomas.ab@samsung.com>
 <CAKohpo=-duhJ-4iaqBG+eUCkoV_qwAu93FgUxmYS5erNTpLoMA@mail.gmail.com>
 <20140514081739.0b66587e@amdc2363>
 <CAKohpomdjDDBjuPcAsaCcavvVgcX5977gDWyjeqmULadq_Pw8w@mail.gmail.com>
 <CAJuA9ajtCAGpBkSBH64bpTAbZKqPHTiDBFspuoXE1MSLyOyRPw@mail.gmail.com>
Message-ID: <CAKohpo=yLtGB=N2BrZuMGOrs_6Y06ULGfMwSkxQHV2r831bVgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 May 2014 19:13, Thomas Abraham <ta.omasab@gmail.com> wrote:
> Okay, so you are suggesting that Kconfig entry used to select
> cpufreq-cpu0 should also enable CPU_FREQ_BOOST_SW config as well.

I never said that... That should be enabled by your defconfig instead.
What I said was, don't put code within any #ifdefs in cpufreq-cpu0.
