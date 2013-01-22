From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Jan 2013 00:09:20 -0800
Subject: [PATCH 2/7] ARM: sunxi: Add pinctrl driver for Allwinner SoCs
In-Reply-To: <CACRpkdb8xLeP+RB+JfuEQu=MQ0yO6tVFasVrMsOE4FSfJHrOiw@mail.gmail.com>
References: <1358544639-14761-1-git-send-email-maxime.ripard@free-electrons.com>
 <1358544639-14761-3-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdb8xLeP+RB+JfuEQu=MQ0yO6tVFasVrMsOE4FSfJHrOiw@mail.gmail.com>
Message-ID: <20130122080920.GB27384@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 11:09:07PM +0100, Linus Walleij wrote:
> On Fri, Jan 18, 2013 at 10:30 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The Allwinner SoCs have an IP module that handle both the muxing and the
> > GPIOs.
> >
> > This IP has 8 banks of 32 bits, with a number of pins actually useful
> > for each of these banks varying from one to another, and depending on
> > the SoC used on the board.
> >
> > This driver only implements the pinctrl part, the gpio part will come
> > eventually.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Patch title says "ARM: " but all changed except one line is to the pinctrl
> tree so I have applied it to the pinctrl tree on a separate allwinner
> branch for now (will merge it to devel when deemde stable).
> 
> ARM SoC boys: can I have an ACK on this oneliner?

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
