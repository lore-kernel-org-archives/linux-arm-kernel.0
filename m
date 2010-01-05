From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jan 2010 17:31:20 +0000
Subject: [PATCH v2] scripts: add ARM support to decodecode
In-Reply-To: <20100105070658.766317d2@linux.intel.com>
References: <1262184839-24497-1-git-send-email-rabin@rab.in>
	<20091231051858.GA31256@verge.net.au>
	<20100105145758.GA2690@debian>
	<20100105070658.766317d2@linux.intel.com>
Message-ID: <20100105173120.GA10941@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2010 at 07:06:58AM -0800, Arjan van de Ven wrote:
> I'm fine with this, but I wonder if ARM could switch to the <>
> convention for the faulting instruction, just to keep things
> consistent..

I did mention exactly that on the previous review round on this patch;
the problem is that it won't change older kernels, and if anyone is
still using ksymoops or similar parsing stuff, it could break on
such a change.
