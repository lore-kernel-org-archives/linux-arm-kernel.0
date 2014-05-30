From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 May 2014 11:52:46 +0200
Subject: [PATCH v2 10/11] dts: versatile: add clock tree
In-Reply-To: <1401403221-27523-11-git-send-email-robherring2@gmail.com>
References: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
 <1401403221-27523-11-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdZ7zmcS8uPACR5PoeZUS18MSwMCb2pEY0W0h2kbmVPgXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 12:40 AM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <robh@kernel.org>
>
> The versatile dts is missing any clock data. Add the clocks.
>
> It is not clear from the documentation where pclk comes from, so for
> now it is a dummy clock which is sufficient for things to work.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2:
> - Move and Rename crystal node.
> - Define pclk as 24MHz based on Linus W's input
> - fix timer to be 3 clocks and fix names
> - Fix sspclk clock name

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
