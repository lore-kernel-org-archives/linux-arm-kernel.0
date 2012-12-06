From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 6 Dec 2012 17:37:28 +0800
Subject: [PATCH 6/6 v8] cpufreq, highbank: add support for highbank cpufreq
In-Reply-To: <1354726121-17190-7-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354726121-17190-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354726121-17190-7-git-send-email-mark.langsdorf@calxeda.com>
Message-ID: <20121206093726.GB27003@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 05, 2012 at 10:48:41AM -0600, Mark Langsdorf wrote:
> Highbank processors depend on the external ECME to perform voltage
> management based on a requested frequency. Communication between the
> A9 cores and the ECME happens over the pl320 IPC channel.
> 
> Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
> Cc: shawn.guo at linaro.org

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
