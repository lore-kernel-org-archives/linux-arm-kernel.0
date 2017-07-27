From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 27 Jul 2017 08:22:04 +0200
Subject: [PATCH v2] arm64: dts: xilinx: fix PCI bus dtc warnings
In-Reply-To: <20170726210943.6875-6-robh@kernel.org>
References: <20170726210943.6875-1-robh@kernel.org>
 <20170726210943.6875-6-robh@kernel.org>
Message-ID: <8b5c2d43-5365-0923-c122-84b4b35e3fb3@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.7.2017 23:09, Rob Herring wrote:
> dtc recently added PCI bus checks. Fix these warnings.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: "S?ren Brinkmann" <soren.brinkmann@xilinx.com>
> ---
> v2:
> - rebase on v4.13-rc2
> 
> Michal, you said you applied v1, but it looks like it never was.


I have this in my branch but it wasn't merged to arm-soc tree yet.

https://github.com/Xilinx/linux-xlnx/commits/zynqmp/dt

Thanks,
Michal
