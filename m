From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 23 Dec 2013 17:13:10 +0100
Subject: [PATCH 0/3] ARM: mvebu: minor improvements
In-Reply-To: <1387788491-3168-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1387788491-3168-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20131223161310.GB8292@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 09:48:08AM +0100, Thomas Petazzoni wrote:
> Jason, Gregory, Sebastian, Andrew,
> 
> Here are three patches making minor improvements to the mvebu code
> base.
> 
>  * The first one moves an 370/XP specific declaration to
>    armada-370-xp.h, in preparation for the future addition of the
>    support for other SOCs in mach-mvebu/. It should go to mvebu/soc.
> 
>  * The second one fixes the length of the registers of the Armada XP
>    PMSU. It should go to mvebu/dt. There is no need to push this as a
>    fix, as it *reduces* the length of the register area, so it is
>    really only a cosmetic improvement.
> 
>  * The third one makes a function static. It should to to mvebu/soc.
> 
> Thanks!

Hi Thomas

All look sensible to me,

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew
