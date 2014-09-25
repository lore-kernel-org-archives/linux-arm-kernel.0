From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Sep 2014 09:47:51 +0200
Subject: [PATCH 0/5] pinctrl: samsung: Data structure clean-up
In-Reply-To: <1411499141-26551-1-git-send-email-tomasz.figa@gmail.com>
References: <1411499141-26551-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdZCMD4x+wrvTOrrWK-Dy4_rg6bD2xUAA4jtTGTbT1uDag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 9:05 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> This series intends to clean up data structures used by pinctrl-samsung driver.
> More specifically, it separates initial compile time constants from data used
> at runtime, allowing unused variant data to be dropped and selected structures
> constified to improve safety.

I like the patch set, tried to apply it but patch 3/5 failed to apply to the
devel branch for pinctrl.

Can you rebase this on my "devel" branch, include Marek's Tested-by
tag and resend, and I'll take it for v3.18.

Yours,
Linus Walleij
