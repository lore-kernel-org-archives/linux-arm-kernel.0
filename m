From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 12 May 2016 14:43:08 +0200
Subject: [PATCH v8 1/2] Documentation: DT: dma: Add Xilinx zynqmp dma
 device tree binding documentation
In-Reply-To: <1463056164-3210-1-git-send-email-appanad@xilinx.com>
References: <1463056164-3210-1-git-send-email-appanad@xilinx.com>
Message-ID: <57347A5C.1080606@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2016 02:29 PM, Kedareswara rao Appana wrote:
[...]
> +- xlnx,include-sg	: Indicates the controller to operate in simple or
> +			  scatter gather dma mode

This is also a software runtime configuration parameter.
