From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 7 Oct 2013 08:24:40 +0530
Subject: [PATCH] cpufreq: sa11x0: Fix build
In-Reply-To: <1381056329-3382-1-git-send-email-broonie@kernel.org>
References: <1381056329-3382-1-git-send-email-broonie@kernel.org>
Message-ID: <CAKohpo=9t2BZsiDowKei9w7Mi92g41ZWNe7R9-G=vf0JS3X8Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2013, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> Commit 22c8b4f140 (cpufreq: sa11x0: Expose frequency table) added use of
> struct cpufreq_frequency_table to mach-sa1100/generic.h but did not ensure
> that the struct was declared, causing build failures on machines using that
> header. Fix this.
>
> Reported-by: Olof's autobuilder <build@lixom.net>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>
> The relevant commit is in the cpufreq tree in -next.

I have already sent relevant fix to Rafael for this, which
looks similar to this.. And I am waiting for Rafael to merge
it with offending commit...
