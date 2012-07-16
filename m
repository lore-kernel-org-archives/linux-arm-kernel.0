From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 16 Jul 2012 14:09:35 -0400 (EDT)
Subject: [PATCH 0/8] ARM: support for Moschip MCS814x SoCs
In-Reply-To: <201207151959.19620.arnd@arndb.de>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
 <201207151959.19620.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1207161402320.14068@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 15 Jul 2012, Arnd Bergmann wrote:

> On Sunday 15 July 2012, Florian Fainelli wrote:
> > This patchset adds basic support for Mocship MCS814x, and in particular
> > MCS8140, and allows one booting to user space. Two off-the-shelf boards
> > are support: Tigal/Robotech RBT-832 and Devolo dLAN USB Extender.
> > 
> > Support for other on-board peripherals will obviously be contributed later
> > once the basic SoC support has been accepted.
> 
> Hi Florian,
> 
> This looks quite nice at first sight, but I have to say that your timing
> is rather unfortunate. We're getting rather close to the 3.6 merge window,
> so there is not much time to review the platform thoroughly before that
> and I'd feel more comfortable about putting it into 3.7. I'll let others
> weigh in, too. At least there is no risk of regressions for a new platform
> getting added, so if other people think we should take it for 3.5, I might
> get convinced.

You should take it if no apparent issues are found.  As you say, this 
might even be broken and no one else would be affected.  The only 
reasons I would not push it upstream are about the code i.e if the code 
causes merge conflicts, isn't up to date with the latest kernel 
infrastructures or has coding style issues, etc.


Nicolas
