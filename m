From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Oct 2012 19:03:37 +0100
Subject: Problem with 64-bit registers on i.MX53
In-Reply-To: <20121008175052.GG2302@linaro.org>
References: <20121008160841.GM19651@pengutronix.de>
 <20121008170124.GZ4625@n2100.arm.linux.org.uk>
 <20121008171011.GA4625@n2100.arm.linux.org.uk>
 <20121008175052.GG2302@linaro.org>
Message-ID: <20121008180337.GB4625@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2012 at 06:50:52PM +0100, Dave Martin wrote:
> Just for my curiosity, can you let me know what compiler version you're
> using and the disassembly?  I'm actually a little surprised to see
> NEON code being generated here, though the patch below fixes what
> definitely looks like a context switch bug for combined v6+v7 kernels...

Well, one such compiler is gcc 4.6.3 in Ubuntu Precise LTS.
