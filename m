From: rui.zhang@intel.com (Zhang Rui)
Date: Mon, 19 Sep 2016 10:44:28 +0800
Subject: [PATCH V2 1/7] dt-bindings: Update QorIQ TMU thermal bindings
In-Reply-To: <CADRPPNQ+hikr1qNK1wPbLnhudUrU1bN_2iuYyRQnqCN4Zwh83Q@mail.gmail.com>
References: <1465270054-31512-1-git-send-email-hongtao.jia@nxp.com>
 <20160608195241.GA6805@rob-hp-laptop>
 <CADRPPNQ+hikr1qNK1wPbLnhudUrU1bN_2iuYyRQnqCN4Zwh83Q@mail.gmail.com>
Message-ID: <1474253068.23153.2.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?, 2016-09-14 at 11:40 -0500, Leo Li wrote:
> On Wed, Jun 8, 2016 at 2:52 PM, Rob Herring <robh@kernel.org> wrote:
> > 
> > On Tue, Jun 07, 2016 at 11:27:34AM +0800, Jia Hongtao wrote:
> > > 
> > > For different types of SoC the sensor id and endianness may vary.
> > > "#thermal-sensor-cells" is used to provide sensor id information.
> > > "little-endian" property is to tell the endianness of TMU.
> > > 
> > > Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> > > ---
> > > Changes for V2:
> > > * Remove formatting chnages.
> > > 
> > > ?Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 7
> > > +++++++
> > > ?1 file changed, 7 insertions(+)
> > Acked-by: Rob Herring <robh@kernel.org>
> Hi Zhang Rui,
> 
> Since you have applied the driver patch, can you also apply the
> binding patch???The binding is supposed to go with the driver.
> 

Do you mean I should take both patch 1/7 and 7/7? I can not see the
other patches in this patch set.

thanks,
rui
