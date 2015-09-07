From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 07 Sep 2015 14:55:54 +0200
Subject: [PATCH v6 1/2] dmaengine: Add Xilinx Central DMA DT Binding
 Documentation
In-Reply-To: <1441629188-17601-1-git-send-email-appanad@xilinx.com>
References: <1441629188-17601-1-git-send-email-appanad@xilinx.com>
Message-ID: <1986807.ieBkZICvCQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 September 2015 18:03:08 Kedareswara rao Appana wrote:
> +- dma-channel child node: Should have only one channel
> 

What is the point of the child node if there is only one instance?

Could you just fold this into the main node instead?

(Sorry jumping in here without looking at the previous versions, I
just returned to work from my parental leave).

	Arnd
