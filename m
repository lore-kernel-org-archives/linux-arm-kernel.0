From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 19 Jul 2013 20:20:11 +0530
Subject: [PATCH v3 2/5] ARM: davinci: da850: override device name of UART
 in DT kernel
In-Reply-To: <1371633342-1210-3-git-send-email-prakash.pm@ti.com>
References: <1371633342-1210-1-git-send-email-prakash.pm@ti.com>
 <1371633342-1210-3-git-send-email-prakash.pm@ti.com>
Message-ID: <51E95223.30704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 June 2013 02:45 PM, Manjunathappa, Prakash wrote:
> Populate OF_DEV_AUXDATA with desired device name so as to prevent
> clk_get failures.

This can be folded into 1/5 itself.

Thanks,
Sekhar
