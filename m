From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Mar 2014 14:43:47 +0100
Subject: [GIT PULL] Allwinner core additions for 3.15
In-Reply-To: <20140313164327.GA13229@lukather>
References: <20140313164327.GA13229@lukather>
Message-ID: <201403171443.47557.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 March 2014, Maxime Ripard wrote:
> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> 
>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> 
> are available in the git repository at:
> 
>   https://github.com/mripard/linux.git tags/sunxi-core-for-3.15
> 
> for you to fetch changes up to 8db21ad469fda194913db2c5b11635bcc21345fc:
> 
>   ARM: sunxi: Add the new watchog compatibles to the reboot code (2014-03-13 11:46:20 +0100)
> 

Merged into next/soc, thanks!

Just for confirmation, I noticed that you are removing the previous "compatible"
strings from sunxi_restart_ids. Is that intentional? It seems like you risk
breaking backwards compatibility.

	Arnd
