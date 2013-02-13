From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Feb 2013 14:36:32 +0100
Subject: [PATCH v2 00/13] drivers: mailbox: framework creation
In-Reply-To: <1360645032-9668-1-git-send-email-s-anna@ti.com>
References: <1360645032-9668-1-git-send-email-s-anna@ti.com>
Message-ID: <CACRpkdZayg-X11ZRnh2Z0i+egBn8Fhwya-6_Yr8wcv+6s0CVqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 5:56 AM, Suman Anna <s-anna@ti.com> wrote:

> I have hosted the series at [3].
> [3] https://github.com/sumananna/mailbox/commits/dbx500-prcmu-mailbox

Suman, I suggest you ask Stepgen Rothwell to include this
branch into the linux-next tree, so we can get some
rotation of this stuff in preparation for the v3.10 merge
window. (It's not going in now anyway.)

If it proves to survive some smoke testing there, I suggest
we proceed to pull this into the ARM SoC tree early in
the v3.10 kernel cycle, since all the dependencies will be
in ARM SoC anyway.

Yours,
Linus Walleij
