From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 5 Apr 2018 08:46:58 +0200
Subject: [PATCH v5 1/3] regulator: axp20x: add drivevbus support for axp803
In-Reply-To: <CAMty3ZD3ohpgqsBjgNztpyHOmmcu_y7vuUOoop8y-+OpWjLYGA@mail.gmail.com>
References: <20180327053104.3812-1-jagan@amarulasolutions.com>
 <CAMty3ZD3ohpgqsBjgNztpyHOmmcu_y7vuUOoop8y-+OpWjLYGA@mail.gmail.com>
Message-ID: <20180405064658.rz2grnpm5fq45lhu@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2018 at 12:11:39PM +0530, Jagan Teki wrote:
> On Tue, Mar 27, 2018 at 11:01 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> > Like axp221, axp223, axp813 the axp803 is also supporting external
> > regulator to drive the  OTG VBus through N_VBUSEN PMIC pin.
> >
> > Add support for it.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> > Changes for v5:
> > - Collect Chen-Yu reviewed-by tag
> > Changes for v4:
> > - rebase on master
> > Changes for v3:
> > - Update drivevbus in table of regulators
> 
> Can you pick these, has some dependency with drivevbus on other
> patches.

I'm not the regulator maintainer, nor the AXP maintainer for that
matter. Mark Brown and Chen-Yu are, respectively.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180405/c84ca2f0/attachment-0001.sig>
