From: sbkim73@samsung.com (Sangbeom Kim)
Date: Fri, 24 Aug 2012 16:41:32 +0900
Subject: [alsa-devel] [PATCH] ASoC: samsung dma - prepare dma in
 start/resume trigger path
In-Reply-To: <1345755069-9512-1-git-send-email-dgreid@chromium.org>
References: <1345755069-9512-1-git-send-email-dgreid@chromium.org>
Message-ID: <00df01cd81cb$e21d2f00$a6578d00$@com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Thu, Aug 24, 2012 at 5:51 AM, Dylan Reid wrote:
> On suspend all dma transactions are terminated (by the stop/suspend
> trigger calling ops->stop), they need to be set up again during resume.
> Move the prepare op to the start/resume/unpause trigger path so that dma
> and audio will restart on resume/unpause.
Do you mean that currently, suspend/resume can't be supported?

Thanks,
Sangbeom.
