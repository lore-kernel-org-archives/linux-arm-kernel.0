From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Jul 2011 18:26:57 +0200
Subject: [PATCH v2] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <BANLkTinkHcuXuWpCxq3tnU_10trPTjDucg@mail.gmail.com>
References: <1309231954-23260-1-git-send-email-bs14@csr.com>
	<201106301236.25822.arnd@arndb.de>
	<BANLkTinkHcuXuWpCxq3tnU_10trPTjDucg@mail.gmail.com>
Message-ID: <201107011826.57660.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 July 2011, Barry Song wrote:
> except Wall St and stock, i really didn't realize CSR is something
> related with 'China Security & Surveillance Tech. Inc' . it seems CSR
> is much more extensively known as a company in Wireless Technology,
> Audio, Connectivity and GPS.
> if we lost this name, people might not know it came from that CSR
> focusing on Wireless/Audio/Connectivity/GPS. people will ask, what is
> CSRXF? if we really use stock sticker symbols, CSR.L is the more
> normal symbol in UK market. if we move to stock sticker symbol, could
> we use CSR.L?

CSR.L sounds ok to me, but I don't know if there are limitations on the
character set used here, can we have dots?

Maybe the best solution after all is to go with 'sirf,...': it is
actually a company name, and you own the .com address, and there is
no other company listed on wallstreet with that shortcut.

	Arnd
