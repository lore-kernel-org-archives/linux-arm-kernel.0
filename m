From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 30 May 2011 17:36:00 +0400
Subject: [PATCH] OMAP2/4: PM: Boot message is not an error/info,	and not
	helpful, remove it
In-Reply-To: <1306751527-15929-1-git-send-email-santosh.shilimkar@ti.com>
References: <1306751527-15929-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <4DE39D40.2060500@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Santosh Shilimkar wrote:

> The commit '99aa18278e' removed the boot messege for OMAP3. Do the same

    Please specify that commit's summary in parens -- for the human readers.
Oh, and you don't need quotes around commit ID too.

> for OMAP2 and OMAP4 since it's really just noise in the boot log
> and PM init is always called.

> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

WBR, Sergei
