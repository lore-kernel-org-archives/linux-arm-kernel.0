From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 18 Jan 2012 12:47:18 +0800
Subject: Pinmux bindings proposal
In-Reply-To: <7FE21149F4667147B645348EC6057885093AD9@039-SN2MPN1-013.039d.mgd.msft.net>
References: <74CDBE0F657A3D45AFBB94109FB122FF17801D202F@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC6057885091DEA@039-SN2MPN1-013.039d.mgd.msft.net>
 <20120117082334.GA31295@S2101-09.ap.freescale.net>
 <7FE21149F4667147B645348EC6057885092D56@039-SN2MPN1-013.039d.mgd.msft.net>
 <20120117141322.GA31687@S2101-09.ap.freescale.net>
 <7FE21149F4667147B645348EC6057885093AD9@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <20120118044716.GD563@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 03:44:59AM +0000, Dong Aisheng-B29396 wrote:
...
> > > The real problem is do we need to support individual pin mux Or still
> > > using virtual pin group?
> > > For the way Stephen proposed, we can only support individual pin mux
> > > Since IMX pins are not grouped together in HW.
> > >
> > I do not see any problem here.  If you look at the first column of 'mux'
> > property of node pinmux-usdhc1, it is a group of pins for usdhc1.
> > Isn't it one virtual pin group for usdhc1?
> > 
> If we treat the whole pins in 'mux' property as a group,
> There may be potential inconsistent issue since Tegra will treat each
> One in the list of 'mux' as a group.
> And it would be a problem for pinctrl core to parse it in a standard way.
> 
Based on my understanding, the 'group' given by 'mux' property may be
a group of pin/group defined by hardware, or mixing of the two.

-- 
Regards,
Shawn
