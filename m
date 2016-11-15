From: julia@ni.com (Julia Cartwright)
Date: Tue, 15 Nov 2016 09:43:52 -0600
Subject: [PATCH 1/2] ARM: zynq: Remove skeleton.dtsi
In-Reply-To: <2d42e25d7dd03e562e12e71fd037837737115940.1479218844.git.michal.simek@xilinx.com>
References: <2d42e25d7dd03e562e12e71fd037837737115940.1479218844.git.michal.simek@xilinx.com>
Message-ID: <20161115154352.GG30999@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 03:07:26PM +0100, Michal Simek wrote:
> Based on
> "ARM: dts: explicitly mark skeleton.dtsi as deprecated"
> (sha1: 9c0da3cc61f1233c2782e2d3d91e3d0707dd4ba5)
> skeleton.dtsi is deprecated.
> Move address and size-cells directly to zynq-7000.dtsi.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Julia Cartwright <julia@ni.com>
