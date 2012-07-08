From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 8 Jul 2012 15:26:01 +0800
Subject: [PATCH] ARM: PRIMA2: convert to common clk and finish full clk
 tree
In-Reply-To: <201207070841.41494.arnd@arndb.de>
References: <1341568806-842-1-git-send-email-Barry.Song@csr.com>
 <CAGsJ_4x=GuY4RPk+SaWisoar1Qb0Y8ox0TqXN2hbsNvOHi_J4Q@mail.gmail.com>
 <20120707023201.GC1230@gmail.com> <201207070841.41494.arnd@arndb.de>
Message-ID: <CAGsJ_4wy67=OSP8qYwf-q77486ttt0YDqPzy1YER=Bj9G4=F3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

2012/7/7 Arnd Bergmann <arnd@arndb.de>:
> On Saturday 07 July 2012, Mike Turquette wrote:
>> I don't mind dropping your patches from clk-next and taking new ones.
>> Go ahead and send me a new patch which does everything instead of an
>> incremental patch to simply 'git mv' the code.  Feel free to split the
>> patch up if needed.
>
> FWIW, I would always recommend doing this in two patches, one that changes
> the code and one that moves the file, in either order. The main difference
> is that for those who cannot use 'git diff -M', reviewing the patch becomes
> much easier when it doesn't look like one file is removed and another
> completely different file is added.

i tend towards the latter one. i am thinking those might be two jobs:
1. change the current drivers to common clk and finish the whole tree
2. move the updated driver to the right place after 1

so they might be two patches, how do you think?

>
>         Arnd

-barry
