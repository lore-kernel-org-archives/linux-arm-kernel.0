From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 24 Nov 2016 12:33:23 +0000
Subject: ath9k ARMv7 OOPS in v4.8.6, v4.2.8
In-Reply-To: <20161123214053.GJ2799@io.lakedaemon.net>
References: <20161123191539.GF2799@io.lakedaemon.net>
 <20161123195120.GE14217@n2100.armlinux.org.uk>
 <20161123205917.GI2799@io.lakedaemon.net>
 <20161123211745.GF14217@n2100.armlinux.org.uk>
 <20161123214053.GJ2799@io.lakedaemon.net>
Message-ID: <20161124123323.GM2799@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

On Wed, Nov 23, 2016 at 09:40:53PM +0000, Jason Cooper wrote:
> I'm running with ATH9K_DEBUGFS=y now.  If it goes a couple of days
> without crashing, I'll gin up a patch.

Well, it survived overnight, which it's never done before. :-) I'm
testing the relay_open() NULL patch now.

thx,

Jason.
