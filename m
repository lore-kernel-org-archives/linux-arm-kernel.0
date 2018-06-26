From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 Jun 2018 13:12:57 +0100
Subject: [PATCH 0/5] RFC: Mezzanine handling for 96boards
In-Reply-To: <CACRpkdZY0+q=VKrNhk8w-NSn0zbjCqdgdyApBTs+tVRBWm8ReA@mail.gmail.com>
References: <20180618074556.6944-1-linus.walleij@linaro.org>
 <CAK8P3a2KqoX-squhGc8TBuJ==8xxELsuy-H+c1+C7Fu7Z4OjDA@mail.gmail.com>
 <CACRpkdZY0+q=VKrNhk8w-NSn0zbjCqdgdyApBTs+tVRBWm8ReA@mail.gmail.com>
Message-ID: <20180626121257.GE1779@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2018 at 10:02:20AM +0200, Linus Walleij wrote:
> On Mon, Jun 18, 2018 at 2:21 PM Arnd Bergmann <arnd@arndb.de> wrote:

> > - You export symbols in the mezzanine_* namespace, which I think
> >    is a bit too generic and should perhaps contain something related
> >    to  96boards in its name to make it less ambiguous. I suspect we
> >    would add a number of further connectors for hats, capes, lures etc,
> >    which could all be described as mezzanines.

> Michal also brings up the (discoverable!) FMC connectors Xilinx are
> using. So the idea would be to create something generic to help
> probe and populate them all whether partly discoverable or not.

There's also the plug in modules in the Wolfson Cragganmore, there's
enumeration support for that in mainline.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180626/61df6737/attachment.sig>
