From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 22 Jul 2013 15:33:13 +0530
Subject: [PATCH v3 3/5] ARM: davinci: da850: do not specify clock_frequency
 for UART DT node
In-Reply-To: <1371633342-1210-4-git-send-email-prakash.pm@ti.com>
References: <1371633342-1210-1-git-send-email-prakash.pm@ti.com>
 <1371633342-1210-4-git-send-email-prakash.pm@ti.com>
Message-ID: <51ED0361.9020604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 June 2013 02:45 PM, Manjunathappa, Prakash wrote:
> DT kernel on da850-evm comes up with garbled UART logs. This is because
> of mismatch in actual module clock rate and rate specified(clock-frequency)
> in DT blob. kernel should not assume or depend on bootloaders clock
> configuration, instead let it find the clock rate at runtime.
> 
> Issue discussed here before arriving on this implementation:
> "ARM: davinci: da850 evm: update clock rate for UART 1/2 DT nodes"
> https://patchwork.kernel.org/patch/2162271/
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>

Adding to v3.12/soc branch of my tree.

Thanks,
Sekhar
