From: Hong-Xing.Zhu@freescale.com (Richard Zhu)
Date: Thu, 5 Dec 2013 00:46:08 +0000
Subject: [PATCH RFC] PCI: imx6: remove outbound io/mem ATU region mapping
In-Reply-To: <201312041645.21028.marex@denx.de>
References: <1382504143-27915-1-git-send-email-tharvey@gateworks.com>
 <201312031019.58708.marex@denx.de>
 <0E83723C55F66F43A6041464FE31119D47AB51@039-SN2MPN1-013.039d.mgd.msft.net>
 <201312041645.21028.marex@denx.de>
Message-ID: <0E83723C55F66F43A6041464FE31119D47CA2D@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek:


> -----Original Message-----
> From: Marek Vasut [mailto:marex at denx.de]
> Sent: Wednesday, December 04, 2013 11:45 PM
> To: Zhu Richard-R65037
> Cc: Jingoo Han; 'Pratyush Anand'; 'Mohit KUMAR DCG'; 'Tim Harvey'; 'Kishon
> Vijay Abraham I'; linux-pci at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; 'Bjorn Helgaas'; 'Frank Li'; 'Sascha Hauer'; 'Sean
> Cross'; 'Shawn Guo'; 'Siva Reddy Kallam'; 'Srikanth T Shivanand'; 'Troy Kisky';
> 'Yinghai Lu'
> Subject: Re: [PATCH RFC] PCI: imx6: remove outbound io/mem ATU region mapping
> 
> On Wednesday, December 04, 2013 at 03:38:49 AM, Richard Zhu wrote:
> [...]
> > > > [Richard] One Pericom PI7C9X2G303EL pcie switch, and two pcie ep
> > > > deivces(one is intel e1000e nic, the other is one xhci device) are
> > > > tested on imx6q sabresd board.
> > >
> > > How/what does have such pericom switch and can be attached to an MX6
> > > sabresdp ? Where can I get it?
> >
> > [Richard] You can apply the example from Pericom.
> 
> Which one? Please point me to a website or something here.
> 
[Richard] The model of the pcie switch used by me is PI7C9X2G303EL Ver3.0 provided by Pericom.
Here is the url of this switch.
http://www.pericom.com/products/pcie-switch/?part=PI7C9X2G303EL

> > > > Without removing outbound io/mem regions view map during the
> > > > cfg0/1 read/write cycle, both of these devices can't work well at my
> side.
> > > > Works well after remove them during the cfg0/1 read/write cycles.
> > >
> > > Understood. Given that the iATU programming works on other CPUs
> > > (confirmed on st spear and ti dra7xx), we might have some issues
> > > with the iATU on MX6 . Is there anything special about the iATU on the
> MX6 ?
> >
> > [Richard] As I know that there is no anything special about the iATU
> > on MX6. Let me to make a double check with IC team later.
> 
> Oh this would be absolutelly _amazing_ if you could do that. Thank you very
> much!
> [...]
> Best regards,
> Marek Vasut

Best Regards
Richard Zhu
