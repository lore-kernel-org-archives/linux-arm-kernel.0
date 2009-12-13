From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 13 Dec 2009 13:21:05 +0000
Subject: [GIT PULL] pxa: for 2.6.33 - pcmcia fixes + em-x270 usb fix +
	zeus support
In-Reply-To: <f17812d70912130517v3d2ab1dfud8ff67770ba78f46@mail.gmail.com>
References: <f17812d70912130517v3d2ab1dfud8ff67770ba78f46@mail.gmail.com>
Message-ID: <20091213132105.GB12645@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 13, 2009 at 09:17:14PM +0800, Eric Miao wrote:
> Russell,
> 
> The following changes since commit f40542532e96dda5506eb76badea322f2ae4731c:
>   Linus Torvalds (1):
>         Merge branch 'ixp4xx' of git://git.kernel.org/.../chris/linux-2.6
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel
> 
> Eric Miao (2):
>       pcmcia: export pxa2xx_drv_pcmcia_{add_one, ops} to other modules
>       pcmcia: fix now incorrect reference of skt->irq by using
> skt->socket.pci_irq

Please drop these two, I already either have them or a similar fix.
