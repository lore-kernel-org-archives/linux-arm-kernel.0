From: khilman@ti.com (Kevin Hilman)
Date: Wed, 21 Sep 2011 09:43:06 -0700
Subject: [GIT PULL] omap cleanup part1 for v3.2 merge window
In-Reply-To: <2241590.uiCS2D9jjt@wuerfel> (Arnd Bergmann's message of "Wed, 21
	Sep 2011 11:28:31 +0200")
References: <20110917014623.GC2937@atomide.com>
	<201109202334.43213.arnd@arndb.de> <201109202346.11393.arnd@arndb.de>
	<2241590.uiCS2D9jjt@wuerfel>
Message-ID: <87d3et4zj9.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> writes:

> On Tuesday 20 September 2011 23:46:11 Arnd Bergmann wrote:
>
>> It seems that you replace the #ifdef in the board-flash.c file
>> with a similar #ifdef in the header that replaces this with an
>> empty inline function when the object is not built.
>
> Found another similar problem over night, presumably in the voltage series:
>

Found.  Patch below.

If this one is OK, I'll push to my for_3.2/voltage-cleanup branch (which
is already pulled into arm-soc/next/voltage) so just re-pulling will
pick up the fix.

Kevin
