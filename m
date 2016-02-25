From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Feb 2016 16:56:44 -0800
Subject: [PATCH 01/14] pinctrl: sunxi: Add A83T R_PIO controller support
In-Reply-To: <CACRpkdb7=x2bJP1nXpF2bP3U0t+NUHiuw_aeTAhbR8OXOrHn6A@mail.gmail.com>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
 <1454203266-4450-2-git-send-email-vishnupatekar0510@gmail.com>
 <CACRpkdbCgOBQw28d=qc1fAURY3x8UdoWqiMtXMZ=uWLaQj-nbg@mail.gmail.com>
 <20160211123648.GN31506@lukather>
 <CACRpkdaGZ4-S1A9zUUaBXXEazyJf_uZ4ESiBhw-CpozXMxfDHg@mail.gmail.com>
 <20160211151246.GO31506@lukather>
 <CACRpkdb7=x2bJP1nXpF2bP3U0t+NUHiuw_aeTAhbR8OXOrHn6A@mail.gmail.com>
Message-ID: <20160225005644.GC4736@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, Feb 16, 2016 at 12:23:37AM +0100, Linus Walleij wrote:
> On Thu, Feb 11, 2016 at 4:12 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Thu, Feb 11, 2016 at 02:47:57PM +0100, Linus Walleij wrote:
> 
> >> Can you guys supply a MAINTAINERS entry for the sunxi
> >> stuff?
> >
> > We have one, and Chen-Yu is listed as co-maintainer:
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/MAINTAINERS#n911
> 
> Modified request:
> can you put in F: wildcards there to match the files pertaining to
> the sunxi platform, so that scripts/find-maintainer.pl finds them.

I don't really know what you mean, on my laptop, if I run it, I get
the following result:

$ ./scripts/get_maintainer.pl -f drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
Linus Walleij <linus.walleij@linaro.org> (maintainer:PIN CONTROL SUBSYSTEM,commit_signer:2/2=100%)
Maxime Ripard <maxime.ripard@free-electrons.com> (maintainer:ARM/Allwinner sunXi SoC support,commit_signer:1/2=50%)
Chen-Yu Tsai <wens@csie.org> (maintainer:ARM/Allwinner sunXi SoC support)
Fabian Frederick <fabf@skynet.be> (commit_signer:1/2=50%,authored:1/2=50%)
Vishnu Patekar <vishnupatekar0510@gmail.com> (commit_signer:1/2=50%,authored:1/2=50%)
Hongzhou Yang <hongzhou.yang@mediatek.com> (commit_signer:1/2=50%)
linux-gpio at vger.kernel.org (open list:PIN CONTROL SUBSYSTEM)
linux-arm-kernel at lists.infradead.org (moderated list:ARM/Allwinner sunXi SoC support)
linux-kernel at vger.kernel.org (open list)

With both Chen-Yu and I listed as maintainers.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160224/f137e911/attachment-0001.sig>
