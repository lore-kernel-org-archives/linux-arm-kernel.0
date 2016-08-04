From: robh@kernel.org (Rob Herring)
Date: Thu, 4 Aug 2016 12:26:36 -0500
Subject: [PATCH 1/3] Documentation: dt: socfpga: Add Arria10 SD-MMC EDAC
 binding
In-Reply-To: <1470153381-20517-2-git-send-email-tthayer@opensource.altera.com>
References: <1470153381-20517-1-git-send-email-tthayer@opensource.altera.com>
 <1470153381-20517-2-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20160804172636.GA22478@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2016 at 10:56:19AM -0500, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Add the device tree bindings needed to support the Altera SD-MMC
> FIFO buffers EDAC on the Arria10 chip.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
>  .../bindings/arm/altera/socfpga-eccmgr.txt         |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
