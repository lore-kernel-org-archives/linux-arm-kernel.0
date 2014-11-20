From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 17:52:47 +0100
Subject: [PATCH v3 0/2] arm64: Add support for Juno development board
In-Reply-To: <1415727131-4572-1-git-send-email-Liviu.Dudau@arm.com>
References: <1415727131-4572-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <201411201752.47955.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 November 2014, Liviu Dudau wrote:
> Hi,
> 
> This patchset adds device tree support for ARM's AArch64 Juno development
> board. It enables use of various peripherals on the board, from USB and
> networking to I2C and PL011 UART.
> 
> The patches can also be found in the repository at:
> 
>    git://github.com/ARM-software/linux.git juno/dts-for-armsoc

Applied both on the arm64 tree, on top of the directory cleanup branch.

Thanks,

	Arnd
