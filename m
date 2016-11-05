From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Sat, 5 Nov 2016 15:01:45 -0600
Subject: [PATCH v3 0/2] Add TI SCI Reset Driver
In-Reply-To: <20161104174240.9688-1-afd@ti.com>
References: <20161104174240.9688-1-afd@ti.com>
Message-ID: <2a5ddb44-7c6c-1980-5e93-91ef8ff6352a@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/4/16 11:42 AM, Andrew F. Davis wrote:
> Hello all,
>
> This series adds a reset controller driver that uses the TI SCI
> protocol to manage resets.
>
> The TI SCI protocol is used to communicate with power management
> controllers used by some SoCs. These controllers manage the various
> power domains, clocks, and resets available on a SoC.
>
> This series is based on drivers for TI SCI and the first two controlled
> elements above, these series can be found here:
>
> TI-SCI: http://www.spinics.net/lists/arm-kernel/msg536851.html
> PM Domains: http://www.spinics.net/lists/devicetree/msg146621.html
> Clocks: https://www.spinics.net/lists/linux-clk/msg12785.html
>
> Thanks,
> Andrew
>
> Changes from v2:
>  - Merged DT binding patch and reset header patch
>  - Added locking for reset bit mask
>
> Changes from v1:
>  - Revised dt binding
>  - CC Linux ARM list
>
> Andrew F. Davis (2):
>   Documentation: dt: reset: Add TI SCI reset binding
>   reset: Add the TI SCI reset driver
>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
