From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Jan 2015 21:03:31 +0100
Subject: [PATCH v5] clk: sunxi: Add driver for A80 MMC config clocks/resets
In-Reply-To: <CAGb2v65y0KPe7UtguEEPJyFtBD7qoJ=-YT82Mwp+qDPi7PCPYw@mail.gmail.com>
References: <1421768791-20170-1-git-send-email-wens@csie.org>
 <20150120160413.GU4367@lukather>
 <CAGb2v65y0KPe7UtguEEPJyFtBD7qoJ=-YT82Mwp+qDPi7PCPYw@mail.gmail.com>
Message-ID: <20150120200331.GX4367@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 12:09:05AM +0800, Chen-Yu Tsai wrote:
> On Wed, Jan 21, 2015 at 12:04 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Tue, Jan 20, 2015 at 11:46:31PM +0800, Chen-Yu Tsai wrote:
> >> On the A80 SoC, the 4 mmc controllers each have a separate register
> >> controlling their register access clocks and reset controls. These
> >> registers in turn share a ahb clock gate and reset control.
> >>
> >> This patch adds a platform device driver for these controls. It
> >> requires both clocks and reset controls to be available, so using
> >> CLK_OF_DECLARE might not be the best way.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >
> > Merged, thanks!
> 
> plaes on IRC just pointed out the copyright year is wrong....
> 
> Could you fix it before you push it out?
> Sorry about this.

Done, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150120/7cffa87d/attachment.sig>
