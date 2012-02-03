From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 3 Feb 2012 14:12:20 +0200
Subject: patch "tty: serial: OMAP: ensure FIFO levels are set correctly in
 non-DMA" added to tty tree
In-Reply-To: <20120203150708.386951d2@notabene.brown>
References: <13274430881471@kroah.org>
 <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
 <20120126042155.GA3185@suse.de>
 <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
 <20120126191604.GA15516@suse.de>
 <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
 <20120203150708.386951d2@notabene.brown>
Message-ID: <CAMP44s14dGFQgNY3WBqb6-nBFUFNCxhjpSD8Dw0ZTqzKe-dnWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 3, 2012 at 6:07 AM, NeilBrown <neilb@suse.de> wrote:
> If I then enabled runtime_pm with a 5 second autosuspend delay:
> ?CORE is still permanently ON (I think the USB might be doing that).

Maybe related to this:
http://thread.gmane.org/gmane.linux.usb.general/56096

-- 
Felipe Contreras
