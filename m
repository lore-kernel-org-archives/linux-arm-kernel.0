From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Mon, 21 Jan 2013 13:22:03 +0100
Subject: [PATCH 1/2] clocksource: dbx500-prcmu: use relaxed readl variant
In-Reply-To: <1358770172-30125-1-git-send-email-fabio.baltieri@linaro.org>
References: <1358770172-30125-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <20130121122203.GA30289@balto.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 01:09:31PM +0100, Fabio Baltieri wrote:
> From: Rabin Vincent <rabin.vincent@stericsson.com>
> 
> Modify clksrc_dbx500_prcmu_read to replace readl() with readl_relaxed().
> This speeds up calls to the function by about 40%.

Hello John,

these two patches may go in the existing ux500 clksrc branch
together with the nomadik-mtu's patches queued up some time ago.

Can I have your Acked-by for that?

Thanks,
Fabio

-- 
Fabio Baltieri
