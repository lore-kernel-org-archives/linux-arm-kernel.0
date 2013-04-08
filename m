From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 8 Apr 2013 23:34:57 +0200
Subject: [PATCHv7 08/17] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <201304082331.30809.arnd@arndb.de>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364395234-11195-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo7fGPe3wFha36kNMxeRP4gBpBWgfw85aTLey-DSz2ZYew@mail.gmail.com>
 <201304082331.30809.arnd@arndb.de>
Message-ID: <20130408233457.7127eab2@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Mon, 8 Apr 2013 23:31:30 +0200, Arnd Bergmann wrote:

> > Too bad to have to adjust CFLAGS here.  Seems like I remember earlier
> > discussion, but I didn't pay much attention, and if this is the best
> > we can do, I guess it's OK.
> 
> I'm pretty sure I NAK'ed this part. I'm surprised it's still there.

As I said in my reply to Bjorn, it's a mistake. I did so much efforts
to get rid of the mach-mvebu and plat-orion dependencies, that in the
end, I forgot that the original reason was to get rid of those special
cflags.

For sure, I'll send a v8 that has those cflags removed, they are
unneeded.

Sorry for this.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
