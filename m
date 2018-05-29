From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Tue, 29 May 2018 12:57:19 +0530
Subject: [PATCH 0/2] Add Mediatek X20 Development Board support
In-Reply-To: <06dbc5ef-5bba-f3e0-1b57-3eaeab26ed68@gmail.com>
References: <20180529045258.1415-1-manivannan.sadhasivam@linaro.org>
 <06dbc5ef-5bba-f3e0-1b57-3eaeab26ed68@gmail.com>
Message-ID: <20180529072719.GA5529@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Tue, May 29, 2018 at 08:38:27AM +0200, Matthias Brugger wrote:
> Hi Manivannan,
> 
> it's nice to see that someone at Linaro cares about upstreaming the 96 board.
> From what I can see, your patches add the very same support to the board as
> does the mt6797 evaluation board. Do you have plans to upstream more drivers for
> the board? Do you have a roadmap or something?
> 
> I'm asking becuase I don't want to have just another dead devicetree in the
> kernel which does nothing but provides a boot to rootfs. Especially as this can
> be achieved on the same board with the EVB dts.
> 

I can understand your concern here. I do have plans to add more drivers
in the future for this board but I can't give you any roadmap for that
since it mostly falls under the spare time work and I have been doing a
similar kind of work for the Bubblegum-96 board in parallel.

At most I can guarentee that this board's functionality will be added
gradually in upcoming days.

Thanks,
Mani

> Regards,
> Matthias
> 
> On 29/05/18 06:52, Manivannan Sadhasivam wrote:
> > Add devicetree support for Mediatek X20 Development Board by Archermind.
> > This board is based on the Deca-Core MT6797 SoC from Mediatek and is
> > one of the 96Boards Consumer Edition platform.
> > 
> > With this devicetree change, board can boot into initramfs.
> > 
> > More information about this board can be found in 96Boards product page:
> > https://www.96boards.org/product/mediatek-x20/
> > 
> > Manivannan Sadhasivam (2):
> >   dt-bindings: Add vendor prefix for ArcherMind
> >   arm64: dts: Add Mediatek X20 Development Board support
> > 
> >  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
> >  arch/arm64/boot/dts/mediatek/Makefile         |  1 +
> >  .../boot/dts/mediatek/mt6797-x20-dev.dts      | 33 +++++++++++++++++++
> >  3 files changed, 35 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> > 
