From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 19 Dec 2016 20:13:36 -0800
Subject: [PATCH v4 0/2] FPGA: TS-7300 FPGA manager
In-Reply-To: <20161218202158.10582-1-f.fainelli@gmail.com>
References: <20161218202158.10582-1-f.fainelli@gmail.com>
Message-ID: <c964999f-0988-dc41-5e5e-c0ff9c2455b1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/2016 12:21 PM, Florian Fainelli wrote:
> Hi all,
> 
> This patch series adds support for loading bitstreams into the Altera Cyclone II
> connected to an EP9302 on a TS-7300 board.
> 
> Changes in v4:
> 
> - fixed ops->write not to do the final configuration release
> - reordered patches
> 
> Changes in v3:
> 
> - fix write_init and write_complete signatures
> 
> Changes in v2:
> 
> - rebased against fpga/for-next
> - added defines for configuration bits and delays
> - added error mesage if ioremap() fails
> - detailed how the configuration through CPLD is done

Alan, Moritz, thanks for providing Acked-by, I was under the impression
these patches would be taken by you through the FPGA tree, since Hartley
acked the EP93xx part and since that was the tree used as a baseline.

Let me know how you want to proceed, since EP93xx is not as active as
other ARM SoCs, there may not be a specific tree where to stage these
patches (unless you take them).

Thanks!
-- 
Florian
