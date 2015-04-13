From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 01:14:37 +0200
Subject: [PATCH v2 0/7] Basic support to ZTE ZX296702
In-Reply-To: <1427464356-20112-1-git-send-email-jun.nie@linaro.org>
References: <1427464356-20112-1-git-send-email-jun.nie@linaro.org>
Message-ID: <201504140114.37938.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 March 2015, Jun Nie wrote:
> 
> V2 changes vs V1:
>   - Remove private L2 cache code and reuse existing code
>   - Reuse pl011 low level debug code
>   - Revise dts names and doc
>   - Polish clock driver
>   - Add SMP method and support 2nd core powering off
> 

It seems we missed this for 4.1 and I only now found the patches going
through old emails.

A few guidelines to make sure that doesn't happen next time:

- if you think patches are ready to be applied, send them to arm at kernel.org
- if nothing happens within a week, just remind us. Sometimes we are not
  sure if patches are meant for us or not.
- for more help with submission, ask on #armlinux on irc.freenode.net.

Please send the patches again after rebasing them to 4.1-rc1 once that
is released.

	Arnd
