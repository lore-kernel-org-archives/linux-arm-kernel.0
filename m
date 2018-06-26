From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 26 Jun 2018 13:30:11 -0700
Subject: [PATCH v3] ARM: dts: BCM5301X: Add support for Linksys EA9500
In-Reply-To: <20180618174159.86150-1-npcomplete13@gmail.com>
References: <20180222223844.98527-1-npcomplete13@gmail.com>
 <20180618174159.86150-1-npcomplete13@gmail.com>
Message-ID: <32c1b4db-acb8-35ae-eab9-f4e85a204e09@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2018 10:41 AM, Vivek Unune wrote:
> Hardware Info
> -------------
> 
> Processor	- Broadcom BCM4709C0KFEBG dual-core @ 1.4 GHz
> Switch		- BCM53012 in BCM4709C0KFEBG & external BCM53125
> DDR3 RAM	- 256 MB
> Flash		- 128 MB (Toshiba TC58BVG0S3HTA00)
> 2.4GHz		- BCM4366 4?4 2.4/5G single chip 802.11ac SoC
> Power Amp	- Skyworks SE2623L 2.4 GHz power amp (x4)
> 5GHz x 2	- BCM4366 4?4 2.4/5G single chip 802.11ac SoC
> Power Amp	- PLX Technology PEX8603 3-lane, 3-port PCIe switch
> Ports		- 8 Ports, 1 WAN Ports
> Antennas	- 8 Antennas
> Serial Port	- @J6 [GND,TX,RX] (VCC NC)    115200 8n1
> 
> Tested with OpenWrt built with DSA driver and Kernel v4.14
> 
> Signed-off-by: Vivek Unune <npcomplete13@gmail.com>

Applied to devicetree/next, thanks Vivek.
-- 
Florian
