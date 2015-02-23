From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 23 Feb 2015 11:31:34 -0800
Subject: [PATCH 1/3] watchdog: qcom: use timer devicetree binding
In-Reply-To: <1424485176-8348-2-git-send-email-mathieu@codeaurora.org>
References: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org>
 <1424485176-8348-2-git-send-email-mathieu@codeaurora.org>
Message-ID: <20150223193134.GC26070@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 06:19:34PM -0800, Mathieu Olivari wrote:
> MSM watchdog configuration happens in the same register block as the
> timer, so we'll use the same binding as the existing timer.
> 
> The qcom-wdt will now be probed when devicetree has an entry compatible
> with "qcom,kpss-timer" or "qcom-scss-timer".
> 
> Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>
