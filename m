From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Mar 2013 13:14:55 +0100
Subject: [PATCH 6/9] power: pm2301_charger: remove __devinit annotations
In-Reply-To: <1363902674-6456-7-git-send-email-arnd@arndb.de>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <1363902674-6456-1-git-send-email-arnd@arndb.de>
 <1363902674-6456-7-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdZ0mYeNVQ16CkV_S-tO3p2PPd5cgEjiCNQskh4YXkBHjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 10:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> These got missed in the treewide changes because they came in through
> a new branch, and it now breaks allmodconfig builds.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Anton can you pick this fix directly to the power subsystem
tree?

Yours,
Linus Walleij
