From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 May 2015 17:49:40 +0200
Subject: [GIT PULL] SoCFPGA updates for v4.2, version 2
In-Reply-To: <1431526369-1388-2-git-send-email-dinguyen@opensource.altera.com>
References: <1431526369-1388-1-git-send-email-dinguyen@opensource.altera.com>
 <1431526369-1388-2-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <2448400.AWd2MIFq4c@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 May 2015 09:12:49 dinguyen at opensource.altera.com wrote:
> ----------------------------------------------------------------
> SoCFPGA updates for v4.2
> - Add big endian support
> - Add earlyprintk support on UART1 that is used on Arria10
> - Remove the need to map uart_io_desc
> - Use of_iomap to map the SCU
> - Remove socfpga_smp_init_cpus as arm_dt_init_cpu_maps is already doing
>   the CPU mapping.
> 

Pulled into next/soc, thanks for the quick update!

	Arnd
