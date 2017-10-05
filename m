From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 05 Oct 2017 13:47:48 +0200
Subject: [PATCH 1/8] pinctrl: meson: remove offset from pinctrl
In-Reply-To: <CACRpkdZJ6YWaMig2HSf6kf3aHHRmQ-ZdB0GhqF7f-EXX6iWLUA@mail.gmail.com>
References: <20170920133927.17390-1-jbrunet@baylibre.com>
 <20170920133927.17390-2-jbrunet@baylibre.com>
 <CACRpkdZJ6YWaMig2HSf6kf3aHHRmQ-ZdB0GhqF7f-EXX6iWLUA@mail.gmail.com>
Message-ID: <1507204068.17300.204.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-10-05 at 13:22 +0200, Linus Walleij wrote:
> On Wed, Sep 20, 2017 at 3:39 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> 
> > Offset on meson pinctrl and gpios is something that was carried from the
> > vendor driver, where there is a weird link between the 2
> > controllers. Since these 2 controllers are independent, this offset adds
> > an unnecessary complexity.
> > 
> > This patch remove this manually set offset and rely on pinctrl to figure
> > out the gpio base offset
> > 
> > Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> 
> Patch applied.

Thx Linus.

Just to be sure, did you remember to squash patch 1 to 5 together ?

I know it is a bit unusual but, as explained earlier, those patches were only
split to ease the review. Keeping the change split would break bisect.

> 
> Yours,
> Linus Walleij
