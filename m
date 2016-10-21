From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Oct 2016 17:53:48 +0200
Subject: [PATCH 0/6] ARM: sun5i: chip: Misc improvements
In-Reply-To: <CAGb2v65L=Cf1EWgZ1YPyFA_g7aiqAGwNkC-e0vs3OM8BJ2OEbA@mail.gmail.com>
References: <cover.92d041a0a6fe40f1c8839cabb70247445eaffdfb.1476704881.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65L=Cf1EWgZ1YPyFA_g7aiqAGwNkC-e0vs3OM8BJ2OEbA@mail.gmail.com>
Message-ID: <20161021155348.rs2j4jdh3e7kuoly@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 11:02:23AM +0800, Chen-Yu Tsai wrote:
> On Mon, Oct 17, 2016 at 7:48 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > This is a bunch of patches I gathered for the CHIP, that enables a few
> > things, like the WiFi regulators (and its associated power sequence), a few
> > optional buses, etc.

Applied all with your Acked-by

> FYI this series makes more sense if you mention the Pocket CHIP DT overlays.

Not really, most of these patches are for the CHIP itself. The Pocket
CHIP, just like all the other DIPs so far, uses the LCD pins, but
that's pretty much the only DIP-specific patch there.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161021/81295753/attachment.sig>
