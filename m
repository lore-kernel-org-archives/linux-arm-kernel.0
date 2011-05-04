From: oskar.andero@sonyericsson.com (oskar.andero at sonyericsson.com)
Date: Wed, 4 May 2011 17:03:52 +0200
Subject: [PATCH] ARM: Allow for kernel command line concatenation
In-Reply-To: <1302255383-12375-1-git-send-email-oskar.andero@sonyericsson.com>
References: <1302255383-12375-1-git-send-email-oskar.andero@sonyericsson.com>
Message-ID: <20110504150352.GA19335@caracas.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping.

On 11:36 Fri 08 Apr, oskar.andero at sonyericsson.com wrote:
> From: Victor Boivie <victor.boivie@sonyericsson.com>
> 
> This patch allows the provided CONFIG_CMDLINE to be concatenated
> with the one provided by the boot loader. This is useful to
> merge the static values defined in CONFIG_CMDLINE with the
> boot loader's (possibly) more dynamic values, such as startup
> reasons and more.
> 
> Signed-off-by: Victor Boivie <victor.boivie@sonyericsson.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@sonyericsson.com>
> Signed-off-by: Oskar Andero <oskar.andero@sonyericsson.com>
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Acked-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
> ---
Uwe, would you consider merging this patch to your tree or would you
prefer it to go through another maintainer?

Thanks,
-Oskar
