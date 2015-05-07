From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 7 May 2015 15:36:35 -0700
Subject: [PATCH 1/6] ARM: Zynq: DT: Disable xadc node by default in
 zynq-7000.dtsi
In-Reply-To: <1431037945-40360-1-git-send-email-xander.huff@ni.com>
References: <1431037945-40360-1-git-send-email-xander.huff@ni.com>
Message-ID: <20150507223635.GH8150@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-05-07 at 05:32PM -0500, Xander Huff wrote:
> This is the de-facto practice.

For peripherals that might not be pinned out on a board. But the XADC is
always present in Zynq and can be used to read the temperature in any
case.

	S?ren
