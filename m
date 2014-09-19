From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 19 Sep 2014 09:49:39 -0700
Subject: [PATCH 1/5] cpufreq: cpu0: disable unsupported OPPs
In-Reply-To: <1411143381-10516-2-git-send-email-l.stach@pengutronix.de>
References: <1411143381-10516-1-git-send-email-l.stach@pengutronix.de>
 <1411143381-10516-2-git-send-email-l.stach@pengutronix.de>
Message-ID: <CAKohpo=s+X8dXZpcj5q5exR+Q=E-CxTNbdYem4D=zHeQ3A_qXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc'ing Mark Brown to get his views on the idea.

On 19 September 2014 09:16, Lucas Stach <l.stach@pengutronix.de> wrote:
> If the regulator connected to the CPU voltage plane doesn't
> support an OPP specified voltage with the acceptable tolerance
> it's better to just disable the OPP instead of constantly
> failing the voltage scaling later on.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/cpufreq/cpufreq-cpu0.c | 60 ++++++++++++++++++++++++++----------------
>  1 file changed, 37 insertions(+), 23 deletions(-)

And this file doesn't exist anymore (its renamed). Rebase over
Rafael's linux-next branch for that.
