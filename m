From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 5 Mar 2014 09:58:27 +0800
Subject: spear-cpufreq + multiplatform?
In-Reply-To: <20140303180809.GA28282@joshc.qualcomm.com>
References: <20140303180809.GA28282@joshc.qualcomm.com>
Message-ID: <CAOh2x=k6uo23O23RFE5Ld__q=FtQUnbNyJA1O72yf3r_dd8f-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 4, 2014 at 2:08 AM, Josh Cartwright <joshc@codeaurora.org> wrote:
> Hey folks-
>
> I noticed booting today's next on a non-spear platform, that I'm seeing
> the following in my logs:
>
>         [    2.126494] spear_cpufreq: Invalid cpufreq_tbl
>
> Looking closer, it looks like the spear-cpufreq driver has a
> late_initcall() that's not too multiplatform friendly.  Perhaps the
> spear cpufreq initialization routine should be called explicitly from
> some platform-specific code, or explicitly check to ensure it's running
> on SPEAr?

So sorry for that. I can't get it fixed right now as am busy with some
conferences but will mark that in my todo list. Thanks for reporting it.
