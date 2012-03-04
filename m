From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 4 Mar 2012 16:33:00 +0800
Subject: iMX53 quick start board and SATA
In-Reply-To: <4F50C734.90302@linuxtv.org>
References: <4F50C734.90302@linuxtv.org>
Message-ID: <20120304083258.GE10743@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2012 at 02:12:20PM +0100, Michael Hunold wrote:
> Hello all,
> 
> I am trying to setup a iMX53 quick start board. This is my first
> encounter with Freescale, so please bear with me.
> 
> I used the Code Sourcery arm-2011.03 toolchain and a stock Linux 3.2.8
> kernel. I used "mx5_defconfig" and selected support for the "LOCO"
> board, nothing more.
> 
I think with the following patches in Linux 3.2, the i.MX53 SATA
support should be there, though I never played with it.

904c04f [libata] ahci_platform: Add the board_ids and pi refer to different features
d870ea1 MX53 Enable the AHCI SATA on MX53 SMD board
0661b82 MX53 Enable the AHCI SATA on MX53 LOCO board
e97e303 MX53 Enable the AHCI SATA on MX53 ARD board
97915bd AHCI Add the AHCI SATA feature on the MX53 platforms

-- 
Regards,
Shawn
