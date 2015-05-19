From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 May 2015 17:03:09 +0200
Subject: [PATCH v2 07/10] pinctrl: sunxi: Add H3 PIO controller support
In-Reply-To: <CACRpkdZnWavNK_o04-mNmA0eDV+ppQJz8Kt+-OF5M=jgysuO_g@mail.gmail.com>
References: <1431707940-19372-1-git-send-email-jenskuske@gmail.com>
 <1431707940-19372-8-git-send-email-jenskuske@gmail.com>
 <CACRpkdZnWavNK_o04-mNmA0eDV+ppQJz8Kt+-OF5M=jgysuO_g@mail.gmail.com>
Message-ID: <20150519150309.GY4004@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 04:04:58PM +0200, Linus Walleij wrote:
> On Fri, May 15, 2015 at 6:38 PM, Jens Kuske <jenskuske@gmail.com> wrote:
> 
> > The H3 uses the same pin controller as previous SoC's from Allwinner.
> > Add support for the pins controlled by the main PIO controller.
> >
> > Signed-off-by: Jens Kuske <jenskuske@gmail.com>
> 
> Waiting for Maxime's ACKs on these patches before merging.

There's still the modules issue being debated on another patch of this
serie, so there will probably be a v3 of these patches.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150519/c06b196f/attachment.sig>
