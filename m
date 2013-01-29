From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 29 Jan 2013 23:41:57 +0100
Subject: [PATCH 1/3] pinctrl: sunxi: Add of_xlate function
In-Reply-To: <1359313332-12305-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1359313332-12305-1-git-send-email-maxime.ripard@free-electrons.com>
 <1359313332-12305-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdZi0zCNf6LDd9UAcd57kFqqWyteVqxL8WfDrFfrt9_5sQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 8:02 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Since the pin controller of sunxi chips is represented as a single bank
> in the driver.
> Since this is neither convenient nor represented that way in the
> datasheets, define a custom of_xlate function with the layout <bank pin
> flag>
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

This does not apply and I only have 1/3 it seems?

Sorry, help me understand which order these patches go in...

Here is my allwinner branch:
http://git.kernel.org/?p=linux/kernel/git/linusw/linux-pinctrl.git;a=shortlog;h=refs/heads/allwinner-sunxi

Yours,
Linus Walleij
