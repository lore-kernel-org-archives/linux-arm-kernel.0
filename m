From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 29 Jul 2012 21:25:10 +0100
Subject: [PATCH 1/7] ASoC: dapm: If one widget fails, do not force all
 subsequent widgets to fail too
In-Reply-To: <1343392734-11805-2-git-send-email-lee.jones@linaro.org>
References: <1343392734-11805-1-git-send-email-lee.jones@linaro.org>
 <1343392734-11805-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20120729202510.GB4384@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 01:38:48PM +0100, Lee Jones wrote:
> If a list of widgets is provided and one of them fails to be added as
> a control, the present semantics fail all subsequent widgets. A better
> solution would be to only fail that widget, but pursue in attempting
> to add the rest of the list.

You've completely ignored my question about why this is better.

This is also *clearly* not an urgent bugfix.
