From: fengguang.wu@intel.com (Fengguang Wu)
Date: Tue, 11 Mar 2014 12:45:55 +0800
Subject: [PATCH v5] can: xilinx CAN controller support.
In-Reply-To: <1964213d-6bd9-49fa-805e-42e1e0630fd5@VA3EHSMHS029.ehs.local>
References: <5254bfec-c6fd-4681-a34d-706d51e60fbb@VA3EHSMHS004.ehs.local>
 <531DD493.3030306@monstr.eu> <531DD5E7.7090406@pengutronix.de>
 <3245971.RIuVmbVL0Z@wuerfel>
 <1964213d-6bd9-49fa-805e-42e1e0630fd5@VA3EHSMHS029.ehs.local>
Message-ID: <20140311044555.GA12373@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > You probably want something like
> > 
> > 	config CAN_XILINX
> > 	tristate "Xilinx CAN"
> > 	depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
> > 	depends on COMMON_CLK && HAS_MMIO  # whatever you need for other architectures
> 
> Fengguang: Are you use COMPILE_TEST in zero day testing system?

Yeah, the randconfig build/boot tests should cover both COMPILE_TEST
and !COMPILE_TEST cases.

Thanks,
Fengguang
