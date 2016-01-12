From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jan 2016 23:29:21 +0100
Subject: [PATCH V2 0/5] PCIe Xilinx generic driver for Microblaze and
In-Reply-To: <1452620173-4905-1-git-send-email-bharatku@xilinx.com>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com>
Message-ID: <33382572.XZxh3toaBY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 January 2016 23:06:08 Bharat Kumar Gogada wrote:
> This patch series does modifications to pcie-xilinx.c, to support common
> driver on both Zynq and Microblaze architectures.
> Microblaze pci-common.c has been modified to support generic driver.
> 
> I'm aware Paul Burton <paul.burton@imgtec.com> has also sent patches
> related to pcie-xilinx.c, but I'm unable to comment on them. 
> I request Paul Burton to please add me in cc list so that I can comment on
> those patches.

Very nice work overall!

I've commented on a few smaller things that I think could be improved.

	Arnd
