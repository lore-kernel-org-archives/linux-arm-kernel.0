From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 7 Mar 2014 15:53:21 -0800
Subject: [PATCH RFC v2 07/11] tty: xuartps: Replace function and symbol
 prefix
In-Reply-To: <1394219614-3197-8-git-send-email-soren.brinkmann@xilinx.com>
References: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
 <1394219614-3197-8-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <e88dccf5-e7a0-4fe0-86e0-5c20eabbdd97@VA3EHSMHS029.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-03-07 at 11:13AM -0800, Soren Brinkmann wrote:
> Use 'CDNS_UART' or 'cdns_uart' instead of 'XUARTPS' and 'xuartps' as
> function and symbol prefix. This is essentially doing:
>  - s/XUARTPS/CDNS_UART/g
>  - s/xuartps/cdns_uart/g
> The only exception is PORT_XUARTPS, which stays as is, due to its
> exposure to user space.

If nobody objects, I'll squash this into 5/11 'tty: xuartps: Rebrand
driver as Cadence UART'.

	S?ren
