From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 10:54:00 +0200
Subject: [PATCH 03/34] pinctrl: mvebu: armada-375: remove non-existing
 NAND re/we pins
In-Reply-To: <1433868446-11028-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdb+W8ds8wCUPgmtXUjtkEom1TwW6HyQ4bpk9nBMvh+oaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 6:46 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> After updating to a more recent version of the Armada 375, we realized
> that some of the pins documented as having a NAND-related
> functionality in fact did not have such functionality. This commit
> updates the pinctrl driver accordingly.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: <stable@vger.kernel.org> # v3.15+
> Fixes: ce3ed59dcddd ("pinctrl: mvebu: add pin-muxing driver for the Marvell Armada 375")

Patch applied.

Yours,
Linus Walleij
