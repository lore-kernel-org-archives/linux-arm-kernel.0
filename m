From: sean@mess.org (Sean Young)
Date: Wed, 1 Feb 2017 22:49:57 +0000
Subject: [PATCH v2] Documentation: devicetree: meson-ir:
 "linux,rc-map-name" is supported
In-Reply-To: <CAFBinCDF2d36E2hp7w_ehqdErdZPK9maQLpBmqMoGMPZmTTqqQ@mail.gmail.com>
References: <20170131212112.5582-1-martin.blumenstingl@googlemail.com>
 <20170201221415.22794-1-martin.blumenstingl@googlemail.com>
 <CAFBinCDF2d36E2hp7w_ehqdErdZPK9maQLpBmqMoGMPZmTTqqQ@mail.gmail.com>
Message-ID: <20170201224957.GA3631@gofer.mess.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 11:26:14PM +0100, Martin Blumenstingl wrote:
> On Wed, Feb 1, 2017 at 11:14 PM, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> > The driver already parses the "linux,rc-map-name" property. Add this
> > information to the documentation so .dts maintainers don't have to look
> > it up in the source-code.
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> > Changes since v1:
> > - removed character which shows up as whitespace from subject
> I have verified that I really sent this without a whitespace (I'm
> using git send-email, so the patch is not mangled by some webmailer) -
> unfortunately it seems to appear again (maybe one of the receiving
> mail-servers or the mailing-list software does something weird here).
> 
> @Mauro: can you handle this when you merge the patch - or do you want
> me to push this to some git repo from which you can pull?

I'll apply it to my rc-tree and fix up any problems.


Sean
