From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 10 Jun 2016 18:18:27 +0530
Subject: [PATCH] ARM: davinci: remove unused davinci-i2s pdata
In-Reply-To: <1462802388-25088-1-git-send-email-petr@barix.com>
References: <1462802388-25088-1-git-send-email-petr@barix.com>
Message-ID: <575AB71B.9070007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 May 2016 07:29 PM, Petr Kulhavy wrote:
> The davinci-i2s driver ("davinci-mcbsp") does not use platform
> data any longer. Remove the dummy pdata provided by the board
> drivers dm355, dm365, dm644x and neuros-osd2.
> 
> Signed-off-by: Petr Kulhavy <petr@barix.com>
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applied to v4.8/cleanup

Thanks,
Sekhar
