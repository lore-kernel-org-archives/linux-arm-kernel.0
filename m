From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 22 Jun 2011 16:09:35 +0300
Subject: [RFC 0/8] Introducing a generic AMP/IPC framework
In-Reply-To: <201106221505.32531.arnd@arndb.de>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<201106211620.02065.arnd@arndb.de>
	<BANLkTim1kN2f41Cfz70=g4a_+gPPrWDacA@mail.gmail.com>
	<201106221505.32531.arnd@arndb.de>
Message-ID: <BANLkTi=1LPxiQFUbsLG+Dp1c0P9p_Ew6xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 4:05 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Ok, I see. In that case I agree that using debugfs is fine, but I would
> recommend trying to use fewer macros and just open-coding the file
> operations for better readability.

Sure thing. It didn't end up saving much code eventually, too, so I'll
just remove it.
