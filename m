From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 11 Apr 2013 20:48:21 -0400
Subject: [PATCHv8 12/19] arm: mvebu: add PCIe Device Tree informations
 for Armada 370
In-Reply-To: <20130412002811.GS28693@titan.lakedaemon.net>
References: <1365541601-14095-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1365541601-14095-13-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130412002811.GS28693@titan.lakedaemon.net>
Message-ID: <20130412004821.GT28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 08:28:11PM -0400, Jason Cooper wrote:
> On Tue, Apr 09, 2013 at 11:06:33PM +0200, Thomas Petazzoni wrote:
> > The Armada 370 SoC has two 1x PCIe 2.0 interfaces, so we add the
> > necessary Device Tree informations to make these interfaces availabel.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/armada-370.dtsi |   51 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> 
> Patches 12 through 18 applied to mvebu/dt.  Now Gregory can rebase LPAE
> :)

Gregory,

Hold off for an hour or so.  I just realized that mvebu/fixes contains a
few more relevant dts changes than I had pulled in to mvebu/dt.  I'll
let you know once I push an updated branch.

thx,

Jason.
