From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Oct 2012 14:42:49 +0200
Subject: [PATCH 2/2] Revert "spi/pl022: enable runtime PM"
In-Reply-To: <20121023114130.GW4477@opensource.wolfsonmicro.com>
References: <1349452272-4002-1-git-send-email-ulf.hansson@stericsson.com>
 <1349452272-4002-2-git-send-email-ulf.hansson@stericsson.com>
 <CAPDyKFqfE0u2CPzFKeHBE1LMtuetWabR94KuASPNhw4StDCfjw@mail.gmail.com>
 <20121023111019.GV4477@opensource.wolfsonmicro.com>
 <20121023111656.GT21164@n2100.arm.linux.org.uk>
 <20121023114130.GW4477@opensource.wolfsonmicro.com>
Message-ID: <CACRpkdZxradXJ5BfKZw8880=dnDLOkWWq4ZhZSkmudiuh=HZXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 1:41 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

> I have to say I had been under the impression that Linus' series that I
> applied the other day dealt with all the outstanding stuff here; the
> issues with this have been the awful changelogs and the overalapping
> sets of patches.

It did I think it was patch [1/4] (same subject as this thread),
http://sourceforge.net/mailarchive/forum.php?thread_name=1350476818-13056-1-git-send-email-linus.walleij%40stericsson.com&forum_name=spi-devel-general
to which you replied:

> This was already applied, applied the rest thanks.

So it probably wasn't and it's just some mishap so
that 2,3,4 /4 were applied while 1/4 was actually needed
to.

Yours,
Linus Walleij
