From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 14 May 2014 19:50:56 +0530
Subject: [PATCH v4 1/8] cpufreq: cpufreq-cpu0: allow use of optional boost
 mode frequencies
In-Reply-To: <CAJuA9ahiOz6heULQLaKZyB=2auXRmKmC6N1oMVTa3RENiPbR7g@mail.gmail.com>
References: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
 <1400029876-5830-2-git-send-email-thomas.ab@samsung.com>
 <CAKohpo=-duhJ-4iaqBG+eUCkoV_qwAu93FgUxmYS5erNTpLoMA@mail.gmail.com>
 <20140514081739.0b66587e@amdc2363>
 <CAKohpomdjDDBjuPcAsaCcavvVgcX5977gDWyjeqmULadq_Pw8w@mail.gmail.com>
 <CAJuA9ajtCAGpBkSBH64bpTAbZKqPHTiDBFspuoXE1MSLyOyRPw@mail.gmail.com>
 <CAKohpo=yLtGB=N2BrZuMGOrs_6Y06ULGfMwSkxQHV2r831bVgg@mail.gmail.com>
 <CAJuA9ahiOz6heULQLaKZyB=2auXRmKmC6N1oMVTa3RENiPbR7g@mail.gmail.com>
Message-ID: <CAKohpompE8dgE2uePvM52K+99CvRt2Z6kXkgSTi6_Bcd9OC2ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 May 2014 19:48, Thomas Abraham <ta.omasab@gmail.com> wrote:
> Okay, I get the point about #ifdef in cpufreq-cpu0. What about your
> earlier comment about the new Kconfig entry ("Get rid of this.. just
> not required.")? The new Kconfig entry would be needed in that case.

The only place you used that ifdef was in cpufreq-cpu0, which we
already decided should stay without any ifdefs..

Now, you must enable CPU_FREQ_BOOST_SW from your defconfig.

Did I make it clear this time ?

--
viresh
