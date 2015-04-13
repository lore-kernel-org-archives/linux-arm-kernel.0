From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 00:58:06 +0200
Subject: [GIT PULL] ARM: mvebu: fixes changes for v4.0
In-Reply-To: <552772FF.3080807@free-electrons.com>
References: <552772FF.3080807@free-electrons.com>
Message-ID: <201504140058.07146.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 April 2015, Gregory CLEMENT wrote:
> Here is the second pull request for fixes for mvebu for v4.0.
> Actually it is not a critical one, so it's fine applying it only
> on v4.1 if you are not comfortable to send for v4.0
> 

We missed the chance for 4.0, pulled into next/dt, thanks for
updating the changelog.

Let's hope nobody did a third-party bootloader for this board that
matches the old kernel behavior ;-)

	Arnd
