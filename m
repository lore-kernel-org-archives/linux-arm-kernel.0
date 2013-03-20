From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 20 Mar 2013 15:51:44 +0800
Subject: [PATCH 1/3] ARM: imx: enable anatop suspend/resume
In-Reply-To: <20130320204554.GA13929@ubuntu>
References: <1363801180-8284-1-git-send-email-b20788@freescale.com>
 <20130320072930.GC26941@S2101-09.ap.freescale.net>
 <20130320204554.GA13929@ubuntu>
Message-ID: <20130320075141.GE26941@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 04:45:54PM -0400, Anson Huang wrote:
> > > +void imx_anatop_pre_suspend(void)
> > 
> > static?
> This function will be called outside this file, so we can NOT use static here.

Sorry, I mistakenly put the comment there.

Shawn
