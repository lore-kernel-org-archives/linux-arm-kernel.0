From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 11 Jan 2012 21:11:36 +0800
Subject: [PATCH 6/6] dma/imx-sdma: check whether event_id0 < 32 when set
 event_mask
In-Reply-To: <20120111005322.GB2414@b20223-02.ap.freescale.net>
References: <1326178910-14044-1-git-send-email-richard.zhao@linaro.org>
 <1326178910-14044-6-git-send-email-richard.zhao@linaro.org>
 <20120110142008.GE26599@S2101-09.ap.freescale.net>
 <20120110142939.GB2019@richard-laptop>
 <20120110153836.GA27831@S2101-09.ap.freescale.net>
 <20120111005322.GB2414@b20223-02.ap.freescale.net>
Message-ID: <20120111131134.GB20968@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 08:53:23AM +0800, Richard Zhao wrote:
> The kernel don't have event_id < 32 case yet. I found the bug when
> I review the code.

I tested audio on imx51, in which case SSI0 TX event number is 29.
I do not see any problem without applying this patch.

-- 
Regards,
Shawn
