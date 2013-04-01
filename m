From: simon.guinot@sequanux.org (Simon Guinot)
Date: Mon, 1 Apr 2013 18:44:11 +0200
Subject: [PATCH] ARM: kirkwood: DT board setup for CloudBox
In-Reply-To: <20130330150807.GQ13280@titan.lakedaemon.net>
References: <1364555206-5870-1-git-send-email-simon.guinot@sequanux.org>
 <20130329153132.GJ13280@titan.lakedaemon.net>
 <20130329184109.GA16404@kw.sim.vm.gnt> <51568B89.1060009@free.fr>
 <20130330150807.GQ13280@titan.lakedaemon.net>
Message-ID: <20130401164411.GD16404@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 30, 2013 at 11:08:07AM -0400, Jason Cooper wrote:
> On Sat, Mar 30, 2013 at 07:51:53AM +0100, Chris Moore wrote:
> > Hi Simon et al.
> > 
> > Le 29/03/2013 19:41, Simon Guinot a ?crit :
> > >On Fri, Mar 29, 2013 at 11:31:32AM -0400, Jason Cooper wrote:
> > >>Neat! another new board!
> > >Others are coming :)
> > 
> > That's great, thank you.
> > 
> > >>On Fri, Mar 29, 2013 at 12:06:46PM +0100, Simon Guinot wrote:
> > >>>This patch adds DT board setup for the LaCie NAS CloudBox. The CloudBox
> > >>>is a low cost NAS based on the Network Space v2.
> > >>>
> > >>>Chipset list:
> > >>>- CPU MARVELL 88F6702 1Ghz
> > >>>- SDRAM memory: 256MB DDR2-800 (2x128MB x8) 400Mhz
> > >>>- 1 Ethernet Gigabit port (PHY MARVELL 88E1318)
> > >>>- SPI flash, NOR 512KB
> > >>>- 1 push button
> > >>>- 2 LEDs (red and blue)
> > >>>
> > >>>+
> > >>>+/ {
> > >>>+	model = "LaCie CloudBox";
> > >>>+	compatible = "lacie,cloudbox", "marvell,kirkwood-88f6702", "marvell,kirkwood";
> > >>Is there a more specific string we can add here?  eg
> > >>"lacie,cloudbox-MODEL", "lacie,cloudbox", ...
> > >Unfortunately no. CloudBox is a product name which is also used by LaCie
> > >to name the board and the project.
> > >
> > 
> > I think it really is necessary to have a more specific name.
> > I have two, very different, products corresponding to LaCie CloudBox:
> > - The first one was a small black one with a 2.5" disk reviewed
> > here: http://www.smallnetbuilder.com/cloud/cloud-storage/462-lacie-cloudbox-reviewed
> > - The later one is a larger white one with a 3.5" disk described
> > here: http://www.smallnetbuilder.com/nas/nas-news/31927-lacie-relaunches-its-cloud-connected-nas
> 
> In this case, we usually look for a model number on the back and append
> that to the compatible string.  There are three model numbers listed
> here [1] under specifications, based on capacity.

Hi Jason,

I don't believe this numbers are related with the board. I will check
but IMHO "lacie,cloudbox" is a correct compatible string.

Thanks,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130401/5eb8734a/attachment-0001.sig>
