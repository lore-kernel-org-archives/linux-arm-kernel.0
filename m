From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 May 2014 13:20:19 +0200
Subject: [PATCH] ARM: realview: basic device tree implementation
In-Reply-To: <26412341.aCOKep5CZC@wuerfel>
References: <1395826060-26662-1-git-send-email-linus.walleij@linaro.org>
 <4327457.yKTHVHA17K@wuerfel> <26412341.aCOKep5CZC@wuerfel>
Message-ID: <CACRpkdbH4WrMgmj+sdgx83KncV4iGTqvve_QisP14uuLP6XS2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 10:09 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> Catalin originally added the sparsemem hack. I asked him today about
> it, and he also thinks that sparsemem without the hack should work,
> as long as there is highmem support. I think we can either do away
> with it entirely, or use the patch below to keep it alive.

IMO the patch make things worse. I'd just say we switch it to use highmem
and get rid of the madness.

Anyone claiming to be running performance-critical loads on the PBX
is either insane or a liar.

Yours,
Linus Walleij
