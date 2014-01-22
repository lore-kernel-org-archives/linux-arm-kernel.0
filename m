From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Jan 2014 10:58:38 +0100
Subject: [PATCH RFC 4/6] net: rfkill: gpio: add device tree support
In-Reply-To: <CAAVeFuKFfAvSPYLmvWV5jjT-peZFJ8sJ2bbh4F=JAYoWLhjZpA@mail.gmail.com>
References: <1389941251-32692-1-git-send-email-wens@csie.org>
 <CAAVeFuLP4MkfXGG1FMauvUw_J63zRXdhGwxqYy5W98L1wCQNbw@mail.gmail.com>
 <CACRpkdYiy+sya6NqRfAmsrFOXvaa3qX=qjRuTDW1vZVSaG1+Gg@mail.gmail.com>
 <201401211335.16885.arnd@arndb.de>
 <CAAVeFuKFfAvSPYLmvWV5jjT-peZFJ8sJ2bbh4F=JAYoWLhjZpA@mail.gmail.com>
Message-ID: <CACRpkdZbb=eO8YRtMn6hW0vn97PkHUo88e_o61DEC8=wPY3_PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 3:53 PM, Alexandre Courbot <gnurou@gmail.com> wrote:

> The good (or bad, rather) thing about DT is that we can do whatever we
> please with the new bindings: decide which name or which index
> (doesn't matter here) a GPIO should have. However we don't have this
> control over ACPI, where nothing guarantees that the same index will
> be used for the same GPIO function.

It's not like ACPI will impose some tables on us and expect us to
use them as-is no matter how crazy they are. Then indeed the whole
idea of unifying ACPI and DT accessors would be moot and it would
only work by mistake or as a good joke.

The situation with ACPI is just like with DT, it is assumed that the
author of these tables also look at the Linux kernel drivers to figure
out what argument goes where and we can influence them.

Yours,
Linus Walleij
