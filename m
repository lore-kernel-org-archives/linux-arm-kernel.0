From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 7 Mar 2014 15:16:06 -0800
Subject: [PATCH RFC v2 09/11] ARM: multi_v7_defconfig: Adopt to UART
 driver renaming
In-Reply-To: <1394219614-3197-10-git-send-email-soren.brinkmann@xilinx.com>
References: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
 <1394219614-3197-10-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <726e4ba5-be0b-49d8-80f1-04cf05599ba4@TX2EHSMHS031.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-03-07 at 11:13AM -0800, Soren Brinkmann wrote:
> The Xilinx UARTPS driver has been renamed to Cadence UART.  Remove
> the stale Xilinx UARTPS config options and add Cadence UART instead.

This will also be dropped, since the corresponding renaming of config
symbol gets dropped.

	S?ren
