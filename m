From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 20 May 2010 13:05:14 +0800
Subject: usb gadget on zaurus and kexec
In-Reply-To: <20100519154618.GA26381@atrey.karlin.mff.cuni.cz>
References: <20100519154618.GA26381@atrey.karlin.mff.cuni.cz>
Message-ID: <AANLkTim49akRJK0BN_Qk1wL6e5mrdjZioDjGNWlrjUVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 19, 2010 at 11:46 PM, Cyril Hrubis <metan@ucw.cz> wrote:
> Hi!
> After some testing I found out that no usb gadget (g_ether, g_mass_storage, ...)
> is working after zaurus boots with kexec. So it seems like some missing
> initalization (it's working after doing reboot again) anybody has any clue,
> patch or ideas how to debug this?
>

Dumping out the registers of the two situations and doing a comparison then
might be a quick way.
