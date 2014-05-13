From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 May 2014 11:24:24 +0200
Subject: [PATCH 1/2] gpio: omap: prepare and unprepare the debounce clock
In-Reply-To: <536B2CEE.4010809@ti.com>
References: <1398233465-8845-1-git-send-email-rnayak@ti.com>
 <1398233465-8845-2-git-send-email-rnayak@ti.com>
 <536B2CEE.4010809@ti.com>
Message-ID: <CACRpkdZ2EhKyjg6_txGByN501QiOOQ+N5rvDZDm_jqNRWZxN5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 8, 2014 at 9:06 AM, Rajendra Nayak <rnayak@ti.com> wrote:

> Do you mind picking this fix up via the GPIO tree?

Yes, it's merged to my devel branch now with the ACKs.

> Alternatively you could
> Ack this if you are fine and we can take both Patch 1/2 and Patch 2/2 from this
> series via the OMAP tree.

This probably will not work as I have a set of other changes to this
driver in my tree.

> Patch 2/2 has a dependency on Patch 1/2 and they need to go in in that order else
> gpio would break. More discussions are here [1].

Tell me if I should prepare an immutable tag on my branch that you
can pull in. I want an explicit handshake with the platform
maintainer for this kind of stuff.

Yours,
Linus Walleij
