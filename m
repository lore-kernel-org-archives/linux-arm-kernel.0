From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 2 May 2011 13:12:00 -0400 (EDT)
Subject: Patch 6853/1 incorrectly moved to superseeded ?
In-Reply-To: <4DBEDD44.7040509@nokia.com>
References: <4DBEDD44.7040509@nokia.com>
Message-ID: <alpine.LFD.2.00.1105021308030.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 May 2011, Viktor Rosendahl wrote:

> Hello Russell,
> 
> I got a message that you moved my patch "Patch 6853/1: Fix ldrd/strd emulation
> for kprobes" to superseeded based on the assumption that it would have been
> superseeded by John Medhurst's patch "ARM: kprobes: Fix emulation of LDRD and
> STRD instructions".
> 
> However, when I look at John's patch, it seems to me that his patch is
> supposed to sit on top of my patch, not to replacing it.
> 
> Nicolas and Tixy, feel free to correct me if I am wrong.

I picked up a patch called "Fix ldrd/strd emulation" from you on the 
mailing list and included it in the kprobes branches along with Tixy's 
patches for RMK to pull.  So I suppose that RMK discarded it from the 
patch system on that basis.


Nicolas
