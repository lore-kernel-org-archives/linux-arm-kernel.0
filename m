From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Mon, 02 Apr 2012 17:30:54 +0300
Subject: MMC is broken on mx28evk
Message-ID: <4F79B81E.7090000@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

I built U-Boot 2012.04-rc1 and tried it with mx28evk. MMC seems to be 
broken. Reverting your commit 3687c4 (i.MX28: Do data transfers via DMA 
in MMC driver) fix the issue.

Also there is issue in setting MAC address. Console logs are at the end 
of this mail.

Best regards,
Lauri Hintsala


---

U-Boot 2012.04-rc1 (Apr 02 2012 - 17:19:53)

Freescale i.MX28 family at 454 MHz
DRAM:  128 MiB
MMC:   MXS MMC: 0
MMC0: DMA transfer failed
MMC0: DMA transfer failed
MMC0: DMA transfer failed
MMC0: DMA transfer failed
MMC init failed
Using default environment

In:    serial
Out:   serial
Err:   serial
Net:   FEC0
Warning: failed to set MAC address
, FEC1
Warning: failed to set MAC address

Hit any key to stop autoboot:  0
MX28EVK U-Boot > mmc rescan
MMC0: DMA transfer failed
MMC0: DMA transfer failed
MMC0: DMA transfer failed
MMC0: DMA transfer failed
