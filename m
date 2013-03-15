From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Mar 2013 10:18:13 +0000
Subject: [PATCH 2/3] mfd: Make AB8500_CORE select POWER_SUPPLY to fix
 build error
In-Reply-To: <20130315064436.GD12559@zurbaran>
References: <1363298204-8014-1-git-send-email-arnd@arndb.de>
 <1363298204-8014-2-git-send-email-arnd@arndb.de>
 <20130315064436.GD12559@zurbaran>
Message-ID: <201303151018.13518.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 March 2013, Samuel Ortiz wrote:
> On Thu, Mar 14, 2013 at 10:56:39PM +0100, Arnd Bergmann wrote:
> > 
> > Please apply to MFD tree for 3.9
> Already applied to mfd-fixes.
> 

For some reason I did not see it when I rebased my patches on top of linux-next
to make sure I don't send any patches again that are already queued up.

Is there a reason why mfd-fixes is not part of linux-next?

	Arnd
