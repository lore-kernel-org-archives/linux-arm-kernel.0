From: robh@kernel.org (Rob Herring)
Date: Fri, 19 Jan 2018 17:13:40 -0600
Subject: [PATCHv<8> 1/3] ARM:dt-bindings:display Intel FPGA Video and
 Image Processing Suite
In-Reply-To: <1516011701-2748-2-git-send-email-hean.loong.ong@intel.com>
References: <1516011701-2748-1-git-send-email-hean.loong.ong@intel.com>
 <1516011701-2748-2-git-send-email-hean.loong.ong@intel.com>
Message-ID: <20180119231340.5fizpwtdcv36o3a5@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 06:21:39PM +0800, Hean-Loong, Ong wrote:
> From: Ong, Hean Loong <hean.loong.ong@intel.com>
> 
> Device tree binding for Intel FPGA Video and Image Processing Suite. The binding involved would be generated from the Altera (Intel) Qsys system. The bindings would set the max width, max height, buts per pixel and memory port width. The device tree binding only supports the Intel

Also, wrap your lines.

> Arria10 devkit and its variants. Vendor name retained as altr.
