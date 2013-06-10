From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Jun 2013 17:17:38 +0200
Subject: [PATCH 01/10] ARM: ux500: Add Device Tree nodes for AB8500
 External regulators
In-Reply-To: <1370621488-18130-2-git-send-email-lee.jones@linaro.org>
References: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
 <1370621488-18130-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaXW5z69wA16qbr7TMNQaUH27VpVDFeH-0c-MEa7bJH7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 7, 2013 at 6:11 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The AB8500 has 3 external regulators which are used to control outside
> voltage sources. Some of the core AB8500 use these external regulators
> as a supply, so they must be obtainable via Device Tree.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to my ux500-devicetree branch.

Yours,
Linus Walleij
