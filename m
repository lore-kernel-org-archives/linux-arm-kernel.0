From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 5 Dec 2014 09:20:40 +0100
Subject: zynq-edac reports error
In-Reply-To: <54813C82.4060204@windriver.com>
References: <54813C82.4060204@windriver.com>
Message-ID: <ed50e424ee044beaace8e4df229acd05@BL2FFO11FD058.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2014 06:02 AM, yhu2 wrote:
> We see the following error printout from kernel:
> 
> [2000-01-01 00:00:05.365891] ERROR: xmu03 kernel:[ 5.828996] zynq-edac f8006000.ps7-ddrc: ecc not enabled
> 
> We don't use ECC so the printout is valid. However, it should not be an ERROR priority on this. The edac driver should
> look at the "xlnx,has-ecc" property and take appropriate action.
> 
> Any comments would be appreciated!
> 
> ---
> drivers/edac/zynq_edac.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

This driver is out of mainline that's why you shouldn't CC arm mailing list.
Will reply privately.

Thanks,
Michal
