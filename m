From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 22:21:59 +0200
Subject: [GIT PULL] Allwinner drivers for 4.4, round 1
In-Reply-To: <20151011162642.GA11423@lukather>
References: <20151011162642.GA11423@lukather>
Message-ID: <6783763.jm4ezqcpgx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 11 October 2015 17:26:42 Maxime Ripard wrote:
> ----------------------------------------------------------------
> Allwinner drivers changes for 4.4
> 
> A new driver for the Reduced Serial Bus used in the newer Allwinner SoCs to
> communicate with the PMIC and other devices made by Allwinner (audio codecs
> for example)
> 

Sorry for a belated complaint here. The code looks absolutely fine,
isn't this something that should be in drivers/bus/?

If there is a slight chance that this might be reused on another
soc family, that would be a better place, but even if it's Allwinner
specific it feels cleaner that way.

	Arnd
