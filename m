From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 17 Sep 2010 15:41:13 +0200
Subject: [PATCH] opp: introduce library for device-specific OPPs
In-Reply-To: <1284686973-13993-1-git-send-email-nm@ti.com>
References: <1284686973-13993-1-git-send-email-nm@ti.com>
Message-ID: <AANLkTin2fBriymD7p-YfhPL24hMfYttsZBdighCSJxV2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/17 Nishanth Menon <nm@ti.com>:

> diff --git a/Documentation/power/00-INDEX b/Documentation/power/00-INDEX
> index fb742c2..45e9d4a 100644
> --- a/Documentation/power/00-INDEX
> +++ b/Documentation/power/00-INDEX
> @@ -14,6 +14,8 @@ interface.txt
> ? ? ? ?- Power management user interface in /sys/power
> ?notifiers.txt
> ? ? ? ?- Registering suspend notifiers in device drivers
> +opp.txt
> + ? ? ? - Operating Performance Point library
> ?pci.txt
> ? ? ? ?- How the PCI Subsystem Does Power Management

Hm you add the documentation to the index but not the documentation
itself (easy slip) would you mind posting it?

Yours,
Linus Walleij
