From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 31 Jul 2012 16:38:28 +0100
Subject: [PATCH 2/5] ASoC: ab8500: Inform SoC Core that we have our own
 I/O arrangements
In-Reply-To: <1343745944-18418-3-git-send-email-lee.jones@linaro.org>
References: <1343745944-18418-1-git-send-email-lee.jones@linaro.org>
 <1343745944-18418-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20120731153827.GE4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 03:45:41PM +0100, Lee Jones wrote:
> If codec->control_data is not populated SoC Core assumes we want to
> use regmap, which fails catastrophically, as we don't have one:

Applied.  If you could do resends at a rate somewhat lower than once per
working day that'd be helpful, especially given the number of large
patch serieses that you're sending right now.
