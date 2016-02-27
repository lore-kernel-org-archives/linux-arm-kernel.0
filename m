From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 27 Feb 2016 14:10:32 +0000
Subject: [PATCH] dt-bindings: interrupt-controller: add SoC-specific
 compatible string to Marvell ODMI
In-Reply-To: <1456327494-31358-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1456327494-31358-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160227141032.GF7219@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Morning, Thomas!

On Wed, Feb 24, 2016 at 04:24:54PM +0100, Thomas Petazzoni wrote:
> As requested by Rob Herring, this commit adds a SoC-specific
> compatible string to the Marvell ODMI DT binding.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> This commit applies on top of the Marvell ODMI driver patch, which has
> already been merged.
> ---
>  .../bindings/interrupt-controller/marvell,odmi-controller.txt      | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied to irqchip/mvebu

thx,

Jason.
