From: horms@verge.net.au (Simon Horman)
Date: Mon, 27 Aug 2018 14:35:44 +0200
Subject: [PATCH v4] arm64: dts: renesas: condor/v3hsk: add DU/LVDS/HDMI
 support
In-Reply-To: <fe3794e1-2452-d1af-5c30-203fcbb9932e@cogentembedded.com>
References: <95d0db34-713d-8206-00c2-ee9a42aab823@cogentembedded.com>
 <fe3794e1-2452-d1af-5c30-203fcbb9932e@cogentembedded.com>
Message-ID: <20180827123544.awqip3mbevjvzh7i@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2018 at 07:59:20PM +0300, Sergei Shtylyov wrote:
> Define the Condor/V3HSK board dependent parts of the DU and  LVDS device
> nodes. Also add the device nodes for Thine THC63LVD1024 LVDS decoder and
> Analog Devices ADV7511W HDMI transmitter...
> 
> Based on the original (and large) patch by Vladimir Barinov.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Reviewed-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> ---
> The patch is against the 'renesas-devel-20180822-v4.18' tag of Simon Horman's
> 'renesas.git' repo. The only driver support still unmerged seems to be the
> R8A77980 LVDS support patches...

Thanks, applied for v4.20.
