From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 9 Nov 2015 10:55:55 -0800
Subject: [PATCH] ARM: dt: zynq: Add labels to cpu nodes to allow
 overriding OPPs.
In-Reply-To: <1447095111-22969-1-git-send-email-moritz.fischer@ettus.com>
References: <1447095111-22969-1-git-send-email-moritz.fischer@ettus.com>
Message-ID: <20151109185555.GN6436@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-11-09 at 10:51AM -0800, Moritz Fischer wrote:
> By adding labels to the cpu nodes in the dtsi, a dts that
> includes it can change the OPPs by referencing the cpu0
> through the label.
> 
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
Reviewed-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren
