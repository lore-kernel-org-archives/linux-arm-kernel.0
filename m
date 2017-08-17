From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 10:22:24 -0500
Subject: [PATCHv6 1/3] ARM:dt-bindings Intel FPGA Video and Image
 Processing Suite
In-Reply-To: <1502434187-6407-2-git-send-email-hean.loong.ong@intel.com>
References: <1502434187-6407-1-git-send-email-hean.loong.ong@intel.com>
 <1502434187-6407-2-git-send-email-hean.loong.ong@intel.com>
Message-ID: <20170817152147.d4bqny5wmrexh3bu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 11, 2017 at 02:49:45PM +0800, Hean-Loong, Ong wrote:
> From: Ong Hean Loong <hean.loong.ong@intel.com>

"dt-bindings: display: ..." for the subject. With that,

Acked-by: Rob Herring <robh@kernel.org>

> 
> Device tree binding for Intel FPGA Video and Image
> Processing Suite. The binding involved would be generated
> from the Altera (Intel) Qsys system. The bindings would
> set the max width, max height, buts per pixel and memory
> port width. The device tree binding only supports the Intel
> Arria10 devkit and its variants. Vendor name retained as
> altr.
> 
> Signed-off-by: Ong, Hean Loong <hean.loong.ong@intel.com>
> ---
> V6:
> Fix comments for description

A completely useless version history. You should describe the diff 
between versions.

> 
> V5:
> *Fix comments on description
> *remove bindings for bits per symbol as it has only one value which is 8
> 
> V4:
> *Fix comments on description
> 
> V3:
> *Fix comments on description
> 
> V2:
> *Fix comments on description
> 
> V1:
> *Fix comments on description
> ---
> ---
>  .../devicetree/bindings/display/altr,vip-fb2.txt   | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/altr,vip-fb2.txt
