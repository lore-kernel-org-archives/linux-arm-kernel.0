From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Mar 2015 17:05:33 +0100
Subject: [PATCH] pinctrl: at91: simplify probe error handling
In-Reply-To: <2adab2d9a86d0e44051541052ace08527bdcc045.1425317325.git.baruch@tkos.co.il>
References: <2adab2d9a86d0e44051541052ace08527bdcc045.1425317325.git.baruch@tkos.co.il>
Message-ID: <CACRpkdZsoujmj7+raYc2QA2NZygMy1vmUjU9RVjgryC5h6aeAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 2, 2015 at 6:28 PM, Baruch Siach <baruch@tkos.co.il> wrote:

> There is no code ender the 'err' label. Just return the error code directly.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Patch applied with the ACKs.

Yours,
Linus Walleij
