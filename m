From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 25 Nov 2014 21:15:45 +0100 (CET)
Subject: [PATCH 6/8] cpufreq-dt: free OPP table created during ->init()
In-Reply-To: <1ac3e8c67c7bd2a962aed6561693d16ca5cd9db9.1416910766.git.viresh.kumar@linaro.org>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
 <1ac3e8c67c7bd2a962aed6561693d16ca5cd9db9.1416910766.git.viresh.kumar@linaro.org>
Message-ID: <2021992776.218020.1416946545852.JavaMail.open-xchange@oxbaltgw08.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

> Viresh Kumar <viresh.kumar@linaro.org> hat am 25. November 2014 um 11:34
> geschrieben:
>
>
> OPP layer now supports freeing of OPPs and we should free them once they
> aren't
> useful anymore.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

i applied the complete patch series to my repository and tested successfully the
cpufreq-dt with my i.MX28 board.

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks

Stefan
