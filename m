From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 18 Jan 2011 19:30:46 -0800
Subject: [PATCH] drivers: ld9040 amoled driver support
In-Reply-To: <20110119032518.GD19486@linux-sh.org>
References: <1294893628-16998-1-git-send-email-dh09.lee@samsung.com>
	<4D364EFF.6080401@samsung.com>
	<20110119032518.GD19486@linux-sh.org>
Message-ID: <20110118193046.27790664.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Jan 2011 12:25:18 +0900 Paul Mundt <lethal@linux-sh.org> wrote:

> For now the easiest option is still likely to be just making Andrew aware
> of it, while gradually leaning towards -mm as the primary path for
> backlight patches.

The current status of backlight (and drivers/leds/) it that I review
(lol) and merge the patches and send them upstream.  I cc Richard on
them all and he reviews them if he has the time available.
