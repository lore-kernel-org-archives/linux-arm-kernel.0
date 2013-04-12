From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 12 Apr 2013 14:30:47 +0800
Subject: [PATCH] video: mxsfb: Adapt to new videomode API
In-Reply-To: <5167A8E3.7070109@ti.com>
References: <1365516978-29888-1-git-send-email-fabio.estevam@freescale.com>
 <5165228F.1020805@ti.com>
 <CAOMZO5BY0mpYC1sjkRsnX-jnj8X4u9ZH15GCQ=MqMYeQ-LAfuQ@mail.gmail.com>
 <20130412020202.GC16970@S2101-09.ap.freescale.net>
 <5167A8E3.7070109@ti.com>
Message-ID: <20130412063045.GK16970@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 09:25:39AM +0300, Tomi Valkeinen wrote:
> Fine by me, but wouldn't it be easier to get the mxsfb driver changes
> along with other fbdev changes via my tree? Or do you have dependencies
> to arch changes or such in the mxsfb changes?

I have mach-mxs patches removing auxdata depending on the mxsfb changes.

Shawn
