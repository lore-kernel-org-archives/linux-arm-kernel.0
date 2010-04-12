From: amit.walambe@eurotech.com (Amit Walambe)
Date: Mon, 12 Apr 2010 16:32:14 +0530
Subject: [PATCH 1/2] ixp4xx: base support for Arcom Vulcan
In-Reply-To: <20100412082224.08dadc09@taxman.wild-wind.fr.eu.org>
References: <1270931559-9414-1-git-send-email-maz@misterjones.org>
	<20100412112045.58dad272@ironhide>
	<20100412082224.08dadc09@taxman.wild-wind.fr.eu.org>
Message-ID: <20100412163214.7e31b171@ironhide>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,
On Mon, 12 Apr 2010 08:22:24 +0100
Marc Zyngier <maz@misterjones.org> wrote:
> Actually, this port was done over the week-end *without* access to
> Arcom/Eurotech's source code (the only thing I was able to download
> from the Eurotech web site is the board documentation). I'm usually
> extra careful when it comes to attributions... 
Sorry, I wasn't aware of that. If you did it independently, then I
don't think attribution is required at all.

> Some of the settings have been reverse-engineered from the bootloader
> (the EXP_CS* timing section), and the rest is only based on the
> documentation. That's probably why there is no PC/104 support yet
> (still working on it).
You are most welcome to borrow from the existing Vulcan port. If you
would like to refer to it, please let me know. I will be glad to share
the patches.

Thanks and regards,
- Amit
