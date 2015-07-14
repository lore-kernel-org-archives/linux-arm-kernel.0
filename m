From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jul 2015 10:59:44 +0200
Subject: [PATCH v2 4/9] arm: twr-k70f120m: timer driver for Kinetis SoC
In-Reply-To: <alpine.LNX.2.00.1507011619250.13307@localhost.localdomain>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
 <1435667250-28299-5-git-send-email-pawelo@king.net.pl>
 <alpine.DEB.2.11.1507010944580.3916@nanos>
 <alpine.LNX.2.00.1507011031050.9009@localhost.localdomain>
 <alpine.DEB.2.11.1507011527380.3916@nanos>
 <alpine.LNX.2.00.1507011619250.13307@localhost.localdomain>
Message-ID: <CACRpkdbh063kZtmPf5HLuLXhmXDewG0atDjUt+LE2doGrdB-NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 1, 2015 at 4:20 PM, Paul Osmialowski <pawelo@king.net.pl> wrote:

> -               kinetis_pit_init(kinetis_tmr, (rate / HZ) - 1);

Do you want to do DIV_ROUND_UP() or why is this -1 here?

Yours,
Linus Walleij
