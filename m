From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 29 Mar 2013 13:50:22 -0300
Subject: [PATCH] ARM: mvebu: Add gpio button to Mirabox board
In-Reply-To: <CABx3TkW0P7spbUr5gTRQMz9mqNZeWXQn8z212V1wiOPv135M7w@mail.gmail.com>
References: <CABx3TkVyVAzEJ54FV70fK3BoULKCOkgNcw32_K3XT-oCUWjEfg@mail.gmail.com>
 <20130328033807.GA12212@localhost>
 <CABx3TkW0P7spbUr5gTRQMz9mqNZeWXQn8z212V1wiOPv135M7w@mail.gmail.com>
Message-ID: <20130329165021.GA17433@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 09:13:48PM -0700, Ryan Press wrote:
> Hi Ezequiel,
> 
> On Wed, Mar 27, 2013 at 8:38 PM, Ezequiel Garcia
> <ezequiel.garcia@free-electrons.com> wrote:
> > On Wed, Mar 27, 2013 at 05:42:36PM -0700, Ryan Press wrote:
> >> Ezequiel Garcia wrote:
> >> >
> >> >The Globalscale Mirabox board has a little gpio button
> >> >placed just above the SD card slot; the board user guide labels
> >> >this button as "System reset button".
> >> >
> >> >This patch adds support for this button in the device tree file.
> >> I was not able to get this to work, I think there is
> >> some IRQ problem.  I was able to get it to work with
> >> "gpio-keys-polled" however.
> >>
> >
> > Could you explain what you did and what was your problem?
> 
> Just to be on the same page, I pulled the latest 3-9-rc4, with no
> other changes, and then added your patch.  Does this rely on a patch?
> No interrupt events are shown in /proc/interrupts.  I have a lot more
> things running than your box, maybe there is a conflict.
> 

Try disabling SMP in your config.
> 
> Oh and although I guess the bootloader sets it up, i wouldn't trust
> it.  There should probably be the pinctrl in the device tree, yes?
> 

Yes, you're right. I'll take this into a v2.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
