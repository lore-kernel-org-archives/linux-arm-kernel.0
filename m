From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Jun 2012 19:14:45 +0800
Subject: [PATCH 2/4] pwm: pwm-mxs: use global reset function
 stmp_reset_block
In-Reply-To: <20120626095703.GA20185@avionic-0098.mockup.avionic-design.de>
References: <1340701091-8488-1-git-send-email-shawn.guo@linaro.org>
 <1340701091-8488-3-git-send-email-shawn.guo@linaro.org>
 <20120626095456.GA8687@avionic-0098.mockup.avionic-design.de>
 <20120626095703.GA20185@avionic-0098.mockup.avionic-design.de>
Message-ID: <20120626111443.GA8858@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 11:57:03AM +0200, Thierry Reding wrote:
> > Doesn't this need a depends on/select STMP_DEVICE?
> 
> Upon closer investigation, select STMP_DEVICE seems to be correct.
> 
Yes, you are right.  Will fix it.  Thanks.

-- 
Regards,
Shawn
