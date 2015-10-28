From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 28 Oct 2015 04:27 +0100
Subject: cpufreq: i.MX6: -EPROBE_DEFER fixes
In-Reply-To: <1445503652-777-1-git-send-email-s.hauer@pengutronix.de>
References: <1445503652-777-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1625342.QihRV1d1Kl@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, October 22, 2015 10:47:28 AM Sascha Hauer wrote:
> The i.MX6 cpufreq driver can't cope with -EPROBE_DEFER returned from
> regulator_get/clk_get. This series fix that and some other small issues.
> 
> This series supersedes
> [PATCH 1/2] cpufreq: imx: fix regulator_get error handling
> [PATCH 2/2] cpufreq: imx: fix regulator_get_optional error handling
> from Heiner Kallweit.

I'm expecting a new version of this addressing the review comments to be
submitted.

Thanks,
Rafael
