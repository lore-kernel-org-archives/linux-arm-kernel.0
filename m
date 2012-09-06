From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 6 Sep 2012 18:56:39 +0800
Subject: [PATCH v2] ASoC: samsung dma - Don't indicate support for
 pause/resume.
In-Reply-To: <1346488699-11027-1-git-send-email-dgreid@chromium.org>
References: <1346488699-11027-1-git-send-email-dgreid@chromium.org>
Message-ID: <20120906105626.GH22330@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 01, 2012 at 01:38:19AM -0700, Dylan Reid wrote:
> The pause and resume operations indicate that the stream can be
> un-paused/resumed from the exact location they were paused/suspended.
> This is not true for this driver, the pause and suspend triggers share
> the same code path with stop, they flush all pending DMA transfers.

Applied, thanks.
