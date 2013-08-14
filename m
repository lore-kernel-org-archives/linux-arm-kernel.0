From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 14 Aug 2013 07:56:44 +0530
Subject: [PATCH 0/3] cpufreq: sa11x0: cleanups for 3.13
In-Reply-To: <1437762.edDpfxPldn@vostro.rjw.lan>
References: <cover.1376392060.git.viresh.kumar@linaro.org>
 <1437762.edDpfxPldn@vostro.rjw.lan>
Message-ID: <CAKohpokOmv+CcL61dzkMgTNxY5rKb4A863CUAX_Jav4KyHF3DA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 August 2013 01:31, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, August 13, 2013 07:01:04 PM Viresh Kumar wrote:

> Are the three patches in this series prerequisite for the big target_index
> one?  If so, I think they can go into 3.12 actually, if they are ACKed by the
> appropriate platform maintainers.

Yes, but they depend on cpufreq_table_validate_and_show() which
will also go in 3.13 and so these will be made part of that series in
future..
