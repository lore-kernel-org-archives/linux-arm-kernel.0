From: hongtao.jia@nxp.com (Troy Jia)
Date: Sun, 9 Oct 2016 07:12:46 +0000
Subject: [PATCH V2 1/7] dt-bindings: Update QorIQ TMU thermal bindings
In-Reply-To: <1474253068.23153.2.camel@intel.com>
References: <1465270054-31512-1-git-send-email-hongtao.jia@nxp.com>
 <20160608195241.GA6805@rob-hp-laptop>
 <CADRPPNQ+hikr1qNK1wPbLnhudUrU1bN_2iuYyRQnqCN4Zwh83Q@mail.gmail.com>
 <1474253068.23153.2.camel@intel.com>
Message-ID: <AM4PR0401MB18433BD56D0441C832B06123EBD80@AM4PR0401MB1843.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Zhang Rui [mailto:rui.zhang at intel.com]
> Sent: Monday, September 19, 2016 10:44 AM
> To: Leo Li <pku.leo@gmail.com>; Rob Herring <robh@kernel.org>
> Cc: Troy Jia <hongtao.jia@nxp.com>; devicetree at vger.kernel.org; linux-
> pm at vger.kernel.org; linuxppc-dev <linuxppc-dev@lists.ozlabs.org>; lkml <linux-
> kernel at vger.kernel.org>; Scott Wood <scott.wood@nxp.com>; Eduardo Valentin
> <edubezval@gmail.com>; Kumar Gala <galak@codeaurora.org>; Shawn Guo
> <shawnguo@kernel.org>; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH V2 1/7] dt-bindings: Update QorIQ TMU thermal bindings
> 
> On ?, 2016-09-14 at 11:40 -0500, Leo Li wrote:
> > On Wed, Jun 8, 2016 at 2:52 PM, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Tue, Jun 07, 2016 at 11:27:34AM +0800, Jia Hongtao wrote:
> > > >
> > > > For different types of SoC the sensor id and endianness may vary.
> > > > "#thermal-sensor-cells" is used to provide sensor id information.
> > > > "little-endian" property is to tell the endianness of TMU.
> > > >
> > > > Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> > > > ---
> > > > Changes for V2:
> > > > * Remove formatting chnages.
> > > >
> > > > ?Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 7
> > > > +++++++
> > > > ?1 file changed, 7 insertions(+)
> > > Acked-by: Rob Herring <robh@kernel.org>
> > Hi Zhang Rui,
> >
> > Since you have applied the driver patch, can you also apply the
> > binding patch???The binding is supposed to go with the driver.
> >
> 
> Do you mean I should take both patch 1/7 and 7/7? I can not see the other patches
> in this patch set.

Yes, please take 7/7 as well.
I also reworked the device tree patches and you can find them here:
https://patchwork.kernel.org/patch/9368377/
https://patchwork.kernel.org/patch/9368381/
https://patchwork.kernel.org/patch/9368383/
https://patchwork.kernel.org/patch/9368379/
https://patchwork.kernel.org/patch/9368385/

-Hongtao.

> 
> thanks,
> rui
