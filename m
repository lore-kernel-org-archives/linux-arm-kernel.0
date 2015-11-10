From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 10 Nov 2015 14:52:23 -0800
Subject: [GIT PULL 2/6] ARM: SoC cleanups for v4.4
In-Reply-To: <1447126404-10567-3-git-send-email-olof@lixom.net>
References: <1447126404-10567-1-git-send-email-olof@lixom.net>
 <1447126404-10567-3-git-send-email-olof@lixom.net>
Message-ID: <CA+55aFzUHRvx-=ioeqT-QK+Od6yGixL3q5jit6kD6-Yf5WKXJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 9, 2015 at 7:33 PM, Olof Johansson <olof@lixom.net> wrote:
>
> Conflicts:
>
> OMAP timer code has a treewide fix vs code deletion conflict. Delete
> the code in HEAD, go with contents from branch.

That doesn't look right. It also needs the clocksource_of_init ->
clocksource_probe changes. The code was moved around rather than
deleted.

               Linus
