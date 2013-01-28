From: pavel@denx.de (Pavel Machek)
Date: Mon, 28 Jan 2013 12:19:30 +0100
Subject: [PATCHv1 for soc 2/5] arm: socfpga: Add clock entries to
 socfpga.dtsi
In-Reply-To: <20130128071312.GI25723@quad.lixom.net>
References: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
 <1359075633-13502-3-git-send-email-dinguyen@altera.com>
 <20130128071312.GI25723@quad.lixom.net>
Message-ID: <20130128111930.GD6073@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> On Thu, Jan 24, 2013 at 07:00:30PM -0600, dinguyen at altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Pavel Machek <pavel@denx.de>
> > ---
> >  arch/arm/boot/dts/socfpga.dtsi |   37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> > index 936d230..688729f 100644
> > --- a/arch/arm/boot/dts/socfpga.dtsi
> > +++ b/arch/arm/boot/dts/socfpga.dtsi
> > @@ -78,6 +78,43 @@
> >  			};
> >  		};
> >  
> > +		clkmgr at ffd04000 {
> > +			compatible = "altr, clk-mgr";
> 
> 
> No space after "altr,". Also, this should have documented bindings under
> Documentation/device-tree/bindings (and those should be cc:d to the appropriate
> maintainers).

Are the clk-mgr entries used in this series? I see only definition in
device tree, but no usage... Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
