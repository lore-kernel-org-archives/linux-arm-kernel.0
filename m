From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 17:51:36 -0800
Subject: [GIT PULL] ARM: mvebu: drivers for v4.10 (#1)
In-Reply-To: <87r369bwvn.fsf@free-electrons.com>
References: <87r369bwvn.fsf@free-electrons.com>
Message-ID: <20161119015136.GF2543@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 17, 2016 at 10:49:00PM +0100, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the first pull request for drivers for mvebu for v4.10.
> 
> Gregory
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-drivers-4.10-1
> 
> for you to fetch changes up to d6ea689345ecc27b636a8bb62bf07080f21f110c:
> 
>   ARM/orion/gpio: Replace three seq_printf() calls by seq_puts() in orion_gpio_dbg_show() (2016-10-17 17:40:24 +0200)
> 
> ----------------------------------------------------------------
> mvebu drivers for 4.10 (part 1)
> 
> Clean-up on thegpio driver for old SoCs(non DT)
> 
> ----------------------------------------------------------------
> Markus Elfring (1):
>       ARM/orion/gpio: Replace three seq_printf() calls by seq_puts() in orion_gpio_dbg_show()

This is next/soc material, not driver. Merged there. Thanks.

(Also, please be mindful of patch prefixes. This is again a nonstandard
one).


-Olof
