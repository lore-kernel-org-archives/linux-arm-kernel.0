From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 11:47:17 -0800
Subject: [GIT PULL] at91: dt for 4.5 #1
In-Reply-To: <1450260856-1375-1-git-send-email-nicolas.ferre@atmel.com>
References: <1450260856-1375-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20151222194717.GB30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 11:14:16AM +0100, Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> This is the first PR for AT91 DT material targeted to 4.5. The main part is the
> addition for the new DENX platform. Other things are simply basic fixes and
> updates.
> 
> Thanks, best regards,
> 
> The following changes since commit 31ade3b83e1821da5fbb2f11b5b3d4ab2ec39db8:
> 
>   Linux 4.4-rc3 (2015-11-29 18:58:26 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-dt
> 
> for you to fetch changes up to 0a804b5729bb0021e63662b772db0f52de653056:
> 
>   ARM: at91/dt: sama5d2 Xplained: pmic needs a specific sda hold time (2015-12-15 12:23:32 +0100)

Merged, thanks.

Btw, most other platforms use: ARM: dts: at91: ...   for format, so feel free
to switch to that in the future.


-Olof
