From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 7 Dec 2011 11:39:11 +0100
Subject: [PATCH] ARM: pcontrol_g20_defconfig should not specify
 toolchain path
In-Reply-To: <20111207032631.GA20556@windriver.com>
References: <1323223937-14281-1-git-send-email-paul.gortmaker@windriver.com>
 <20111207031907.GF32515@game.jcrosoft.org>
 <20111207032631.GA20556@windriver.com>
Message-ID: <20111207103911.GA9044@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:26 Tue 06 Dec     , Paul Gortmaker wrote:
> [Re: [PATCH] ARM: pcontrol_g20_defconfig should not specify toolchain path] On 07/12/2011 (Wed 04:19) Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > On 21:12 Tue 06 Dec     , Paul Gortmaker wrote:
> > > Building defconfigs is a routine operation for people checking
> > > code that touches multiple arch.  But this defconfig calls out
> > > a path to a toolchain that most people will never have.
> > > 
> > > The defconfigs should not be calling out site specific toolchain
> > > locations, so delete the setting of CROSS_COMPILE.
> > > 
> > > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > simply drop this defconfig is not maintain
> 
> Sure, that works too.  Do I need to send a delete commit (seems
> somewhat pointless) or can I assume someone else will STONITH it?
please do so

Best Regards,
J.
