From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 13:50:42 +0200
Subject: [PATCH 19/34] pinctrl: mvebu: armada-{370, xp}: normalize ethernet
 txclkout pins
In-Reply-To: <1433868446-11028-20-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-20-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdaZnc8qULmRwC05oKgZxQPVvM2mJRVee3c+Ya1BvoYbcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 6:47 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> This commit normalizes the naming of the Ethernet txclkout pin to be
> the same accross Marvell SoCs. It is worth mentioning that the DT
> binding documentation of the Armada XP was wrong for MPP12: it said
> the function was ge1(txd0), while it is in fact ge1(txclkout). It is
> however not really a fix worth sending to stable since it does not
> change the behavior, and the driver itself was correct.
>
> Since only the subnames are changed, DT backward compatibility is not
> affected.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
