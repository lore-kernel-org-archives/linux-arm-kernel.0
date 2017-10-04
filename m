From: olof@lixom.net (Olof Johansson)
Date: Tue, 3 Oct 2017 18:08:55 -0700
Subject: [GIT PULL] ARM: at91: fixes for 4.14 #1
In-Reply-To: <20170918162029.15894-1-nicolas.ferre@microchip.com>
References: <20170918162029.15894-1-nicolas.ferre@microchip.com>
Message-ID: <20171004010855.4xamlbzxgso26dsh@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 06:20:29PM +0200, Nicolas Ferre wrote:
> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Arnd, Olof,
> 
> Here are some fixes for 4.14. I send them while Alexandre is in the US. The
> most of this PR are modifications to the sama5d27 SOM1 EK board that was
> introducts lately. These modifications are errors due to typos, misunderstanding
> of the DT binding or simply last minute hardware modifications.
> I also added one patch for the AT91 PM subsystem as it is the re-alignment on
> one treewide change by Russell to get rid of virt_to_phys() in low-level code.
> I think that unifying this move the soonest for all ARM platform is better.
> 
> Thanks, best regards,
> 
> The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:
> 
>   Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-fixes
> 
> for you to fetch changes up to 093d79f62a89f47d9b5fd0746768146d9696535c:
> 
>   ARM: at91: Replace uses of virt_to_phys with __pa_symbol (2017-09-18 10:05:38 +0200)

Applied to fixes.


-Olof
