From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jan 2010 09:43:43 +0000
Subject: Module Compilation Error in linux-2.6.15  using floating point
In-Reply-To: <4B46FC7E.9050406@cdotb.ernet.in>
References: <4B46FC7E.9050406@cdotb.ernet.in>
Message-ID: <20100108094343.GB23420@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2010 at 03:05:58PM +0530, jyothi wrote:
> Hello ,
>         I am using arm9 based fujitsu card . I have compiled and ported 
> linux-2.6.15 with eldk4.2. I am trying to insert a module in which I am 
> using floating point operations.

The use of floating point in the kernel is prohibited.
