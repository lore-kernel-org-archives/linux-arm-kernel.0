From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 16 May 2014 09:59:53 +0200
Subject: [PATCH RFC 00/11] Remove mach-kirkwood
In-Reply-To: <8332148.Z1shujgC24@wuerfel>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
 <8332148.Z1shujgC24@wuerfel>
Message-ID: <20140516095953.19522ebd@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Thu, 15 May 2014 16:36:35 +0200, Arnd Bergmann wrote:

> There are three other series that may or may not make it into 3.16
> and that will have conflicts with this one:
> 
> - remove mv78xx0
> - remove mach-dove
> - convert orion5x to multiplatform

The work on Orion5x is still on-going. I'd like to progressively
continue the DT migration of Orion5x, moving to multiplatform, and then
once it's done, move into mach-mvebu. I'd appreciate to not rush things
more than necessary.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
