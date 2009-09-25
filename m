From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 25 Sep 2009 11:15:12 +0200
Subject: About ARM TCM patch
In-Reply-To: <4ABC1D1D.6050506@gmail.com>
References: <4ABC1D1D.6050506@gmail.com>
Message-ID: <63386a3d0909250215k50f10a44qae55da31f97f99c0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/9/25 Peter Chen <hzpeterchen@gmail.com>:

> I read the TCM patch from http://lwn.net/Articles/353032/

Are you trying to use it too?

> 1. After MMU open, the code running at ITCM can't see physical address for
> register.
>
> 2. After MMU open, the code can't run at physical addressed ITCM.

Could this be different between ARM9 (which I use) and ARM11?

Linus Walleij
