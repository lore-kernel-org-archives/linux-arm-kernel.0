From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 24 Nov 2017 13:03:24 +0100
Subject: [RFC PATCH 1/3] dt-bindings: pinctrl: sunxi: document new
 generic binding
In-Reply-To: <CACRpkdbpfkM4odz425+4qyUCF5vqPWBQ=F5Yk7AtJL5SqXghpg@mail.gmail.com>
References: <20171113012523.2328-1-andre.przywara@arm.com>
 <20171113012523.2328-2-andre.przywara@arm.com>
 <CACRpkdbpfkM4odz425+4qyUCF5vqPWBQ=F5Yk7AtJL5SqXghpg@mail.gmail.com>
Message-ID: <20171124120324.da6ihbdirtyi7unx@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Fri, Nov 24, 2017 at 11:19:52AM +0100, Linus Walleij wrote:
> On Mon, Nov 13, 2017 at 2:25 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> 
> > So far all the Allwinner pinctrl drivers provided a table in the
> > kernel to describe all the pins and the link between the pinctrl functions
> > names (strings) and their respective mux values (register values).
> >
> > Extend the binding to put those mappings in the DT, so that any SoC can
> > describe its pinctrl and GPIO data fully there instead of relying on
> > tables.
> > This uses a generic compatible name, to be prepended with an SoC
> > specific name in the node.
> >
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> (...)
> 
> I definately want feedback from Maxime before I do anything with
> this patch series.

So I've been opposed to it as well, for the reasons Rob, Thierry and
you pointed out already in that thread

I just wasn't sure what your opinion on it was, so I didn't answer
just so that I could see if I was the only one pushing back.

So I guess we all agree here.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171124/ed86aab8/attachment-0001.sig>
