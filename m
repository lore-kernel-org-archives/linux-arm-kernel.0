From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Jan 2014 21:26:02 +0100
Subject: [PATCH v2 3/7] tty: serial: Limit msm_serial_hs driver to
 platforms that use it
In-Reply-To: <52C5CA05.5080803@codeaurora.org>
References: <1388438133-431-1-git-send-email-sboyd@codeaurora.org>
 <201401021910.22651.arnd@arndb.de> <52C5CA05.5080803@codeaurora.org>
Message-ID: <1877300.Iu7OMicvV0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 January 2014 12:20:21 Stephen Boyd wrote:
> Yes, we plan to add the code for dma based serial devices into the
> msm_serial.c driver. In the process we'll use the linux DMA apis instead
> of using mach specific ones.

Ok, very good.

	Arnd
