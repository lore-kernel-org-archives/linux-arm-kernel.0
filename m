From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sat, 2 May 2015 22:35:48 +0300
Subject: [PATCH] ARM: proc-feroceon: Fix feroceon_proc_info macro
In-Reply-To: <1430319415-6421-1-git-send-email-andrew@lunn.ch>
References: <20150429140516.GA32151@lunn.ch>
 <1430319415-6421-1-git-send-email-andrew@lunn.ch>
Message-ID: <20150502193548.GB575@fuloong-minipc.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 29, 2015 at 04:56:55PM +0200, Andrew Lunn wrote:
> bf35706f3d09 ("ARM: 8314/1: replace PROCINFO embedded branch with
> relative offset") broke booting for Kirkwood. The kernel would say:
> 
> Starting kernel ...
> 
> Uncompressing Linux... done, booting the kernel.
> 
> Error: unrecognized/unsupported processor variant (0x56251311).
> 
> Fix it by removing the extraneous .long __feroceon_setup from the
> feroceon_proc_info macro.
> 
> Reported-by: Florian Fainelli <f.fainelli@gmail.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Fixes: bf35706f3d09 ("ARM: 8314/1: replace PROCINFO embedded branch with relative offset")

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
