From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Jan 2018 10:44:07 +0100
Subject: [PATCH 2/2] pinctrl: mediatek: mt7622: align error handling of
 mtk_hw_get_value call
In-Reply-To: <0eb8fd904f9b49d0e992bc2ee725d057f94cf735.1515514758.git.sean.wang@mediatek.com>
References: <a26c40a8ad2af3cf81b31ae34bc82c1ef80d9279.1515514758.git.sean.wang@mediatek.com>
 <0eb8fd904f9b49d0e992bc2ee725d057f94cf735.1515514758.git.sean.wang@mediatek.com>
Message-ID: <CACRpkdajTwE-TsVdzXbHcvKOfpHWkmVXQwFPvg=E9yg3SxLX3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 9, 2018 at 5:28 PM,  <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Make consistent error handling of all mtk_hw_get_value occurrences using
> propagating error code from the internal instead of creating a new one.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
