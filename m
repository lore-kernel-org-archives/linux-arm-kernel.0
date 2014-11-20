From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 10:18:11 +0100
Subject: [GIT PULL] arm: pxa: pxa for v3.19
In-Reply-To: <874mtu7q50.fsf@free.fr>
References: <87bnoevq1b.fsf@free.fr> <4686660.cI7P5U9Kgy@wuerfel>
 <874mtu7q50.fsf@free.fr>
Message-ID: <201411201018.11773.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 November 2014, Robert Jarzmik wrote:
> arm: pxa: pxa for v3.19
> 
> Hello Arnd, Kevin, Olof,
> 
> This is a very quiet release, featuring a small cleanup, a tosa change
> on its charger driver, and support for pxa device-tree based pxa27x
> boards.
> 
> The device-tree part will only be fully activated once clocks support
> is fully operation in the common clock framework.


Pulled into next/soc, thanks for your quick update!

On a minor note, the text from the tag is what ends up in the merge commit
log, I've edited it slightly to remove the 'Hello Arnd, Kevin, Olof,'.

	Arnd
