From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Nov 2014 23:33:32 +0100
Subject: [GIT PULL] arm: pxa: pxa for v3.19
In-Reply-To: <87bnoevq1b.fsf@free.fr>
References: <87bnoevq1b.fsf@free.fr>
Message-ID: <201411192333.32448.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 November 2014, Robert Jarzmik wrote:
> Hello Arnd, Kevin, Olof,
> 
> This is a very quiet release, featuring a small cleanup, a tosa change
> on its charger driver, and support for pxa device-tree based pxa27x
> boards.
> 
> The device-tree part will only be fully activated once clocks support
> is fully operational in the common clock framework.

Hi Robert,

Sorry for the delay in replying. I noticed that you have based your
patches on top of v3.18-rc4. If you don't have a strong reason for
doing so, could you send everything based on an -rc1 in the future?

If you don't mind, please rebase and send again.

	Arnd
