From: sboyd@kernel.org (Stephen Boyd)
Date: Sun, 08 Jul 2018 22:29:18 -0700
Subject: [PATCH v9 07/10] firmware: xilinx: Add debugfs for IOCTL API
In-Reply-To: <1529516435-7315-8-git-send-email-jollys@xilinx.com>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
 <1529516435-7315-8-git-send-email-jollys@xilinx.com>
Message-ID: <153111415833.143105.8701882244160397855@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jolly Shah (2018-06-20 10:40:32)
> From: Rajan Vaja <rajanv@xilinx.com>
> 
> Add debugfs file to set/get IOCTL using debugfs interface.

IOCTLs and debugfs aren't the same thing. Why are the two being mixed
together? Is some sort of userspace ABI being created here to control
clks with usermode drivers?
