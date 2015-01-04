From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 04 Jan 2015 17:55:21 +0100
Subject: [PATCH V2 6/9] ARM: sirf: add two debug ports for CSRatlas7 SoC
In-Reply-To: <1420249007-8262-7-git-send-email-21cnbao@gmail.com>
References: <1420249007-8262-1-git-send-email-21cnbao@gmail.com>
 <1420249007-8262-7-git-send-email-21cnbao@gmail.com>
Message-ID: <1669662.yvb7yEMXTf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 03 January 2015 09:36:44 Barry Song wrote:
> From: Guo Zeng <Guo.Zeng@csr.com>
> 
> this patch adds UART0 and UART1 as LLUART port, as the new atlas7
> registers layout are different, it also refines some names of old
> hard-coded MARCOs.
> 
> this patch also moves to CONFIG_DEBUG_UART_PHYS/DEBUG_UART_VIRT
> and debug_ll_io_init().
> 
> Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
> Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> 

The patch looks ok, but if you have the chance, better split it into
two separate patches to do the two things you describe above.

	Arnd
