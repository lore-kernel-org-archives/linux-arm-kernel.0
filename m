From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 10 Feb 2016 15:11:03 +0300
Subject: [PATCH v3 2/8] dma-mapping: add {map,unmap}_resource to
 dma_map_ops
In-Reply-To: <1455065878-11906-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1455065878-11906-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <56BB28D7.1090608@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 2/10/2016 3:57 AM, Niklas S?derlund wrote:

> Add methods to handle mapping of device resources from a physical
> address. This is needed for example to map be able to map MMIO FIFO
                                          ^^^ not needed

> registers to a IOMMU.
>
> Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
[...]

MBR, Sergei
