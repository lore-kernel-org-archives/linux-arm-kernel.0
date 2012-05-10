From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 20:32:52 +0800
Subject: [PATCH V2 03/11] ASoC: imx-audmux: add pinctrl support
In-Reply-To: <20120510092536.GG3908@opensource.wolfsonmicro.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-4-git-send-email-richard.zhao@freescale.com>
 <20120509160005.GG3955@opensource.wolfsonmicro.com>
 <20120510003532.GG2982@b20223-02.ap.freescale.net>
 <20120510063904.GB17875@S2101-09.ap.freescale.net>
 <20120510084403.GA3908@opensource.wolfsonmicro.com>
 <20120510090715.GF17875@S2101-09.ap.freescale.net>
 <20120510092536.GG3908@opensource.wolfsonmicro.com>
Message-ID: <20120510123249.GN17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 10:25:36AM +0100, Mark Brown wrote:
> On Thu, May 10, 2012 at 05:07:18PM +0800, Shawn Guo wrote:
> 
> > Pulling it into arm-soc as a dependency only means we will have it as
> > a base for other branches that depend on.  It does not change anything
> > about how the branch flows to Linus.  Arnd will only send those arm-soc
> > branches that depend on sound/for-3.5 after it gets merged by Linus.
> 
> I don't see what difference that really makes to anything...  exactly
> who sends pull requests to Linus is pretty immaterial, really.

Ok, since you do mind having sound branch pulled into arm-soc to help
this patch go through arm-soc in the coming merge window, let's wait
for the next.

-- 
Regards,
Shawn
