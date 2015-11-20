From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Nov 2015 13:49:55 +0100
Subject: [linux-sunxi] [PATCH 1/5] clk: sunxi: Add support for the H3 usb
 phy clocks
In-Reply-To: <CAGb2v65x5z4Svn+PAmm1W6xZKxP0iFjCodeA0xbf0VLxx5qiWA@mail.gmail.com>
References: <1447616777-24660-1-git-send-email-hdegoede@redhat.com>
 <CAGb2v65x5z4Svn+PAmm1W6xZKxP0iFjCodeA0xbf0VLxx5qiWA@mail.gmail.com>
Message-ID: <20151120124955.GD32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 10:36:02AM +0800, Chen-Yu Tsai wrote:
> On Mon, Nov 16, 2015 at 3:46 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> > From: Reinder de Haan <patchesrdh@mveas.com>
> >
> > The H3 has a usb-phy clk register which is similar to that of earlier
> > SoCs, but with support for a larger number of phys. So we can simply add
> > a new set of clk-data and a new compatible and be done with it.
> >
> > Signed-off-by: Reinder de Haan <patchesrdh@mveas.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151120/29c1c666/attachment.sig>
