From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 8 Sep 2016 17:54:28 +0000
Subject: [RFC 7/7] Make Hi3620 explicit, remove wildcards
In-Reply-To: <20160908172346.27506-7-netz.kernel@gmail.com>
References: <20160908172346.27506-1-netz.kernel@gmail.com>
 <20160908172346.27506-7-netz.kernel@gmail.com>
Message-ID: <20160908175428.GE12916@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 12:23:46PM -0500, Marty Plummer wrote:
> This is a preparatory series for adding the ARMv5/v6 hi3520 SoCs.
> Assumptions were made when adding hi3620 that don't hold water in
> light of adding support for the hi3520 SoC.  Fix the issue by renaming
> config options and other namespaces to avoid collisions with the new
> work.
> 
> Only internal APIs are modified with this series.
> 
> Signed-off-by: Marty Plummer <netz.kernel@gmail.com>
> ---
>  drivers/dma/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This doesn't have to do with DMA, but it's last in the series, so...

I saw on IRC that you have the serial port, vic, and clock at some
initial stage of working for your board, congrats!

I would add those patches to the end of this series implementing that
basic functionality.  That makes it very clear to everyone *why* the
previous patches are necessary.

thx,

Jason.
