From: linux@prisktech.co.nz (Tony Prisk)
Date: Mon, 22 Oct 2012 19:53:25 +1300
Subject: [PATCH 3/3] DOC: PWM: Adding binding document for via,vt8500-pwm
In-Reply-To: <20121022063558.GB17181@avionic-0098.mockup.avionic-design.de>
References: <1350643135-13197-1-git-send-email-linux@prisktech.co.nz>
 <1350643135-13197-3-git-send-email-linux@prisktech.co.nz>
 <20121022063558.GB17181@avionic-0098.mockup.avionic-design.de>
Message-ID: <1350888805.3592.12.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-10-22 at 08:35 +0200, Thierry Reding wrote:
> On Fri, Oct 19, 2012 at 11:38:55PM +1300, Tony Prisk wrote:
> > Add a binding document describing the PWM controller found
> > on arch-vt8500 supported SoCs.
> > 
> > Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> > ---
> >  .../devicetree/bindings/pwm/vt8500-pwm.txt         |   17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/vt8500-pwm.txt
> 
> I think this can be folded into the previous patch. One other comment
> below.
> 
> > diff --git a/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt b/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt
> > new file mode 100644
> > index 0000000..e8ba133
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt
> > @@ -0,0 +1,17 @@
> > +VIA/Wondermedia VT8500/WM8xxx series SoC PWM controller
> > +
> > +Required properties:
> > +- compatible: should be "via,vt8500-pwm"
> > +- reg: physical base address and length of the controller's registers
> > +- #pwm-cells: should be 2.  The first cell specifies the per-chip index
> > +  of the PWM to use and the second cell is the period in nanoseconds.
> > +- clocks: pHandle to the PWM source clock
> 
> I think the common spelling is "phandle".
> 
> Thierry

Will fix the capitalisation and merge this with patch 2.

Regards
Tony P
