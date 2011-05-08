From: m@bues.ch (Michael =?ISO-8859-1?Q?B=FCsch?=)
Date: Sun, 08 May 2011 03:44:41 +0200
Subject: [PATCH][WAS:bcmai,axi] bcma: add Broadcom specific AMBA bus driver
In-Reply-To: <1304796956.13983.65.camel@dev.znau.edu.ua>
References: <1304632783-8781-1-git-send-email-zajec5@gmail.com>
	<201105061605.31625.arnd@arndb.de>
	<BANLkTikjr0ZTNOu69F+iKhwufE9KKMg4Tg@mail.gmail.com>
	<BANLkTimGBNT4FkS4mO9ToLWft0bCEYcEgg@mail.gmail.com>
	<1304790665.13983.10.camel@dev.znau.edu.ua>
	<BANLkTikLFff_86Fvg+jSty9vGLENiELF2Q@mail.gmail.com>
	<1304792795.13983.28.camel@dev.znau.edu.ua>
	<BANLkTi=6BFD4OmtU1WPxjbFJQe36=mZKEA@mail.gmail.com>
	<1304794931.13983.44.camel@dev.znau.edu.ua>
	<BANLkTik9FWgzpNWuMXXRjOj-rDvPNY_nCA@mail.gmail.com>
	<1304796956.13983.65.camel@dev.znau.edu.ua>
Message-ID: <1304819081.21680.6.camel@maggie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2011-05-07 at 22:35 +0300, George Kashperko wrote: 
> dbg_bcma_device_name
> {
> #ifdef DEBUG
> 		case/switch/if/else stuff
> #endif
> 		return NULL;
> }
> But I don't see here much sense to hardcode names other than those of
> buscommons/buscores for debugging purposes.

Would you please read and understand the code before discussing this?
That would help the discussion on the technical side.

Those names are hardcoded by definition. And just like 14e4 is the PCI
ID for Broadcom devices, 800 is the AXI ID for Broadcom Chipcommon.

And building an #ifdef mess around this stuff is not better than having
a few bytes of _helpful_ information messages.
You are absolutely right that those messages only help 1% of the people.
Just as _any_ other kernel message.

-- 
Greetings Michael.
