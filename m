From: robherring2@gmail.com (Rob Herring)
Date: Sat, 8 Mar 2014 13:35:04 -0600
Subject: [PATCH RFC v2 11/11] ARM: zynq: DT: Migrate UART to Cadence
 binding
In-Reply-To: <1394219614-3197-12-git-send-email-soren.brinkmann@xilinx.com>
References: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
 <1394219614-3197-12-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <CAL_Jsq+CUQ4p_NwJ7HvhNSUvkpge0+ZgPxYTWkx3dUNpRJ7trg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 7, 2014 at 1:13 PM, Soren Brinkmann
<soren.brinkmann@xilinx.com> wrote:
> The Zynq UART is Cadence IP and the driver has been renamed accordingly.
> Migrate the DT to use the new binding for the UART driver.
>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>

Acked-by: Rob Herring <robh@kernel.org>
