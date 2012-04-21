From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 21 Apr 2012 12:14:19 +0000
Subject: clps711x patchset
In-Reply-To: <E1SLZ2o-0002iH-SH.shc_work-mail-ru@f105.mail.ru>
References: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
 <201204211140.21564.arnd@arndb.de>
 <E1SLZ2o-0002iH-SH.shc_work-mail-ru@f105.mail.ru>
Message-ID: <201204211214.19447.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 April 2012, Alexander Shiyan wrote:
> The new processors in this series as far as I know there is not and no more will be.
> Existing processors are still produced and used. We use this processor is 4-5 years
> old and still expect to use in the future.

Ok, makes sense.

> I can look at the new code is correct, but check it can only work on our custom board.

That's probably good enough, as most of the changes I expect would either
break the entire platform or just work.

> Of the new things I would like to add the ability to use gpiolib with this type of processor.

Ok, that sounds like a very useful thing to do, I'm looking forward
to the patches.

	Arnd
