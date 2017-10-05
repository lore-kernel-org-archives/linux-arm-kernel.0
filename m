From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Oct 2017 13:44:15 +0200
Subject: [PATCH 7/8] pinctrl: meson-gx: TEST_N belongs to the AO controller
In-Reply-To: <20170920133927.17390-8-jbrunet@baylibre.com>
References: <20170920133927.17390-1-jbrunet@baylibre.com>
 <20170920133927.17390-8-jbrunet@baylibre.com>
Message-ID: <CACRpkdZ-Gc7O=2GEQDX42zHwXcF=karpW-D2LxSW-7+HL5rjBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 3:39 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:

> On meson-gx platforms, TEST_N has been incorrectly declared in the EE
> controller while it belongs to AO controller.
>
> Move the pin to the appropriate controller
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Patch applied.

Yours,
Linus Walleij
