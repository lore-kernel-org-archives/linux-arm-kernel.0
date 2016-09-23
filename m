From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 24 Sep 2016 00:13:12 +0200
Subject: [PATCH 0/2] i2c: meson: add gxbb compatible string
In-Reply-To: <CAL_JsqKNFzo6RWJO5WOvsyO3e4UTo5Zn48aaDac=+uL_CQWerQ@mail.gmail.com>
References: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com>
 <20160915194146.GB7863@katana>
 <CAL_JsqKNFzo6RWJO5WOvsyO3e4UTo5Zn48aaDac=+uL_CQWerQ@mail.gmail.com>
Message-ID: <20160923221312.GA5683@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 10:01:13AM -0500, Rob Herring wrote:
> On Thu, Sep 15, 2016 at 2:41 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > On Wed, Sep 14, 2016 at 11:49:15AM +0200, Jerome Brunet wrote:
> >> This patchset adds a specific compatible string in the Meson I2C driver
> >> for the Amlogic Meson gxbb SoC.
> >>
> >> Other patch series (pinctrl and device tree) are being sent to complete
> >> the i2c support on meson gxbb
> >>
> >> Neil Armstrong (2):
> >>   i2c: meson: add gxbb compatible string
> >>   dt-bindings: i2c-meson: add gxbb compatible string
> >
> > Squashed both patches and applied to for-next, thanks!
> 
> Please don't squash. We ask people to split DT bindings for a reason
> being reviews and bindings may not go thru subsystem maintainers in
> the future. It also makes it harder to find things in the archives or
> patchwork (as does maintainer fixups of subject lines).

I intentionally don't ask people to send me the patches squashed. So,
you will have them seperate in patchwork et al. I only squash them just
before commiting to my tree. That's because I found that when digging
through git history, it is much more convenient to have all the
information in one commit.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160924/4c831195/attachment.sig>
