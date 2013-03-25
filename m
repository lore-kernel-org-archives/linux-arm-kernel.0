From: anton@enomsg.org (Anton Vorontsov)
Date: Sun, 24 Mar 2013 20:09:35 -0700
Subject: [PATCH 6/9] power: pm2301_charger: remove __devinit annotations
In-Reply-To: <CACRpkdZ0mYeNVQ16CkV_S-tO3p2PPd5cgEjiCNQskh4YXkBHjw@mail.gmail.com>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <1363902674-6456-1-git-send-email-arnd@arndb.de>
 <1363902674-6456-7-git-send-email-arnd@arndb.de>
 <CACRpkdZ0mYeNVQ16CkV_S-tO3p2PPd5cgEjiCNQskh4YXkBHjw@mail.gmail.com>
Message-ID: <20130325030934.GA12979@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 01:14:55PM +0100, Linus Walleij wrote:
> On Thu, Mar 21, 2013 at 10:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > These got missed in the treewide changes because they came in through
> > a new branch, and it now breaks allmodconfig builds.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Anton can you pick this fix directly to the power subsystem
> tree?

It appears that Lars-Peter Clausen sent a similar patch a bit earlier. I
added Arnd's Signed-off-by to give a credit, though. So, it is in
battery-urgent now.

Thanks!

Anton
