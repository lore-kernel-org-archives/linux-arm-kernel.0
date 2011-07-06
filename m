From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 6 Jul 2011 21:13:14 +0800
Subject: [PATCH 00/17] Introduce a led trigger for CPU activity
In-Reply-To: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <CAMPhdO-Ln7BmU8jYfEEp3RPa9sgJueTVfsm1phs=NXTC3FPgNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> ?drivers/leds/ledtrig-cpu.c ? ? ? ? ? ? ? ? ? ? | ?144 ++++++++++++
> ?include/linux/leds.h ? ? ? ? ? ? ? ? ? ? ? ? ? | ? 15 ++
> ?105 files changed, 1532 insertions(+), 3119 deletions(-)

Not bad, I like the numbers here. This is definitely a good move.
I had long ago wanted to remove those legacy LED code in mach-pxa.

Thanks Bryan.
