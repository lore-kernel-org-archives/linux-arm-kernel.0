From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 23 Sep 2016 12:50:12 +0200
Subject: [PATCH v2] gpio: Added zynq specific check for special pins on
 bank zero
In-Reply-To: <1474625137-9022-1-git-send-email-navam@xilinx.com>
References: <1474625137-9022-1-git-send-email-navam@xilinx.com>
Message-ID: <c6806094-9809-f488-34d3-d5294e9abe9b@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.9.2016 12:05, Nava kishore Manne wrote:
> From: Nava kishore Manne <nava.manne@xilinx.com>
> 
> This patch adds zynq specific check for bank 0 pins 7 and 8
> are special and cannot be used as inputs
> 
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> ---
> Changes for v2:
>                 -Removed un-used quirks for zynqmp.


You missed Soren's ACK and also Jonas reported by line.
Please add it to v3.

Thakns,
Michal
