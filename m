From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 May 2018 16:27:32 +0530
Subject: [PATCH V2] ARM: DTS: da850-evm: use phandles to extend nodes
In-Reply-To: <20180427094751.19120-1-aford173@gmail.com>
References: <20180427094751.19120-1-aford173@gmail.com>
Message-ID: <95295345-04fd-ff1e-8ad0-1e021bc986a5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 April 2018 03:17 PM, Adam Ford wrote:
> Many node labels in the device tree (like serial0, serial1, etc) are being
> redefined, so let's modernize the device tree by using phandles to
> extend the existing nodes.  This helps reduce the whitespace.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Can you please resend this so it applies to v4.18/dt branch of my tree?
Also, the subject prefix should be "ARM: dts: ".

Thanks,
Sekhar
