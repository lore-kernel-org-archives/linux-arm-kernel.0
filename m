From: marex@denx.de (Marek Vasut)
Date: Wed, 4 Dec 2013 16:45:20 +0100
Subject: [PATCH RFC] PCI: imx6: remove outbound io/mem ATU region mapping
In-Reply-To: <0E83723C55F66F43A6041464FE31119D47AB51@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382504143-27915-1-git-send-email-tharvey@gateworks.com>
 <201312031019.58708.marex@denx.de>
 <0E83723C55F66F43A6041464FE31119D47AB51@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <201312041645.21028.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 04, 2013 at 03:38:49 AM, Richard Zhu wrote:
[...]
> > > [Richard] One Pericom PI7C9X2G303EL pcie switch, and two pcie ep
> > > deivces(one is intel e1000e nic, the other is one xhci device) are
> > > tested on imx6q sabresd board.
> > 
> > How/what does have such pericom switch and can be attached to an MX6
> > sabresdp ? Where can I get it?
> 
> [Richard] You can apply the example from Pericom.

Which one? Please point me to a website or something here.

> > > Without removing outbound io/mem regions view map during the cfg0/1
> > > read/write cycle, both of these devices can't work well at my side.
> > > Works well after remove them during the cfg0/1 read/write cycles.
> > 
> > Understood. Given that the iATU programming works on other CPUs
> > (confirmed on st spear and ti dra7xx), we might have some issues with
> > the iATU on MX6 . Is there anything special about the iATU on the MX6 ?
> 
> [Richard] As I know that there is no anything special about the iATU on
> MX6. Let me to make a double check with IC team later.

Oh this would be absolutelly _amazing_ if you could do that. Thank you very 
much!
[...]
Best regards,
Marek Vasut
