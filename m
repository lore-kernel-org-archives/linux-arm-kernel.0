From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 7 Oct 2016 11:11:22 +0200
Subject: [PATCH 7/9] ARM: sunxi: Remove useless allwinner,drive property
In-Reply-To: <CAGb2v65SmZqR-MJgNxa0RGUYyWgeLHQcQfa0b8U0XiEtp+RfBg@mail.gmail.com>
References: <cover.26c6f76b361d146fb079d744251f020ef6d2db7d.1475489558.git-series.maxime.ripard@free-electrons.com>
 <01cd77ccced851276fcb3625b3d7805f5260fb59.1475489558.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65SmZqR-MJgNxa0RGUYyWgeLHQcQfa0b8U0XiEtp+RfBg@mail.gmail.com>
Message-ID: <20161007091122.GN4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2016 at 10:34:39AM +0800, Chen-Yu Tsai wrote:
> On Mon, Oct 3, 2016 at 6:21 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The allwinner,drive property set to 10mA was really considered as our
> > default. Remove all those properties entirely to make that obvious.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Did you use sed or some other scripting tool to do this patch?
> Including the command should make it easier to verify the result,
> instead of having to go through the 93 files here.

Yeah, I used some dumb sed commands.

Unfortunately, it disappeared from my history, but given my sed-fu, it
was pretty trivial, just a succession of
sed -i 'd/SUN4I_PINCTRL_10_MA' *.dtsi

Something along those lines, and pretty much the same thing for the
next patches.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161007/4122b19e/attachment-0001.sig>
