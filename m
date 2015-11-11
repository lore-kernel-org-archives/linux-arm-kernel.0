From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Nov 2015 16:13:19 +0100
Subject: [PATCH 00/10] ARM MTD AFS v2 partition support
In-Reply-To: <20151111021549.GV12143@google.com>
References: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
 <20151111021549.GV12143@google.com>
Message-ID: <CACRpkdafrinB=EdjRT2coHbG9o==QGPHqe0YNOk99gnFRkP_bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2015 at 3:15 AM, Brian Norris
<computersforpeace@gmail.com> wrote:

> Also, do you have a pointer that documents the v2 format? I can probably
> find something myself, but I'm a bit lazy, and if you have something
> easy to point me to, that'd save me some time :)

There are no documents. The documentation is the source code for
the on-board boot monitor (first thing started by the ROM) that
comes with the board on a CD/DVD. A .h file documents the struct
that is simply written to flash as footer and image info. I don't
think I may post it, the structs in the kernel correspond to these
structs.

Yours,
Linus Walleij
