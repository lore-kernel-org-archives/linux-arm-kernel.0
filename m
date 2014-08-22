From: balbi@ti.com (Felipe Balbi)
Date: Fri, 22 Aug 2014 09:45:24 -0500
Subject: [PATCH] doc: dt/bindings: input: Fix drv260x binding document
In-Reply-To: <00FC9A978A94B7418C33AFAE8A35ED49DF1F66@DFLE09.ent.ti.com>
References: <1408716741-1163-1-git-send-email-dmurphy@ti.com>
 <20140822141532.GC22707@saruman.home>
 <00FC9A978A94B7418C33AFAE8A35ED49DF1F66@DFLE09.ent.ti.com>
Message-ID: <20140822144524.GE22707@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 22, 2014 at 09:25:13AM -0500, Murphy, Dan wrote:
> Felipe
> 
> On 08/22/2014 09:15 AM, Balbi, Felipe wrote:
> > On Fri, Aug 22, 2014 at 09:12:21AM -0500, Dan Murphy wrote:
> >> Update the drv260x dt binding document:
> >> - Change the node name to the devices function not the
> >> device name.
> >> - Add vbat-supply to the example.
> >> - Fix indentation of the example.
> >>
> >> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> >> ---
> >>  .../devicetree/bindings/input/ti,drv260x.txt       |   19 ++++++++++---------
> >>  1 file changed, 10 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/input/ti,drv260x.txt b/Documentation/devicetree/bindings/input/ti,drv260x.txt
> >> index a9c8519..214e25d 100644
> >> --- a/Documentation/devicetree/bindings/input/ti,drv260x.txt
> >> +++ b/Documentation/devicetree/bindings/input/ti,drv260x.txt
> >> @@ -37,15 +37,16 @@ Optional properties:
> >>  			  3.2 v.
> >>  Example:
> >>  
> >> -drv2605l: drv2605l at 5a {
> >> -		compatible = "ti,drv2605l";
> >> -		reg = <0x5a>;
> >> -		enable-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> >> -		mode = <DRV260X_LRA_MODE>;
> >> -		library-sel = <DRV260X_LIB_LRA>;
> >> -		vib-rated-mv = <3200>;
> >> -		vib-overdriver-mv = <3200>;
> >> -};
> >> +haptics:@5a {
> > 
> > haptics: haptics at 5a ??
> > 
> 
> I found both types of entries in the bindings docs.
> There is no consistency within the input bindings documentation.

I could swear neither two types have a colon character between node name
and its base address.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140822/928feccd/attachment.sig>
