From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Mar 2015 10:19:19 +0800
Subject: [PATCH 1/2] ARM: imx6qdl-sabresd: set swbst_reg as vbus's parent
 reg
In-Reply-To: <20150312015417.GA31064@shlinux2>
References: <1425629061-8995-1-git-send-email-peter.chen@freescale.com>
 <20150311012424.GW20455@dragon> <20150312015417.GA31064@shlinux2>
Message-ID: <20150312021917.GD20455@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 09:54:18AM +0800, Peter Chen wrote:
> On Wed, Mar 11, 2015 at 09:24:25AM +0800, Shawn Guo wrote:
> > On Fri, Mar 06, 2015 at 04:04:20PM +0800, Peter Chen wrote:
> > > USB vbus 5V is from PMIC SWBST, so set swbst_reg as vbus's
> > > parent reg, it fixed a bug that the voltage of vbus is incorrect
> > > due to swbst_reg is disabled after boots up.
> > > 
> > > Cc: stable <stable@vger.kernel.org>
> > 
> > It's more idiomatic to put the line in this way:
> > 
> > Cc: stable at vger.kernel.org
> > 
> 
> One benefit for using <stable@vger.kernel.org> over than
> stable at vger.kernel.org directly is it can add "# v3.x+"
> at the last of Cc tag if you want git send Cc tag.
> 
> Cc: <stable@vger.kernel.org> #3.x+ /* git can work */
> 
> Cc: stable at vger.kernel.org #3.x+ /* git can't work */

Yeah, that's true.  What I was really questioning is not
< >, but the alias 'stable' right before it.

Shawn
