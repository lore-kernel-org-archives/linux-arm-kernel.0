From: olof@lixom.net (Olof Johansson)
Date: Thu, 4 Dec 2014 23:24:02 -0800
Subject: [PATCH v4 0/5] Add Spreadtrum Sharkl64 Platform support
In-Reply-To: <1417692860-18841-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <sc9836v4>
 <1417692860-18841-1-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <20141205072402.GC29274@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 04, 2014 at 07:34:15PM +0800, Chunyan Zhang wrote:
> Spreadtrum is a rapid growing chip vendor providing smart phone total solutions.
> 
> Sharkl64 Platform is nominated as a SoC infrastructure that supports 4G/3G/2G
> standards based on ARMv8 multiple core architecture.Now we have only one
> SoC(SC9836) based on this Platform in developing.
> 
> This patchset adds Sharkl64 support in arm64 device tree and the serial driver
> of SC9836-UART.
> 
> This patchset also has patches which address "sprd" prefix and DT compatible
> strings for nodes which appear un-documented.
> 
> This version code was tesed both on Fast Mode and sc9836-fpga board.
> We use the latest boot-wrapper-aarch64 as the bootloader.

Hi,

We only got 3 of the 5 patches of this version (1, 2 and 4). Can you
resend the dts patch to us (I'm guessing the serial one will go through Greg).


Thanks,

-Olof
