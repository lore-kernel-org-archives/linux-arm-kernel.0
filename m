From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 30 Apr 2011 03:28:49 +0200
Subject: AT91: PIO base-address should be calculated by
	processor-specific code
In-Reply-To: <1304086303.21884.36.camel@redbox>
References: <1304086303.21884.36.camel@redbox>
Message-ID: <20110430012849.GB1212@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:11 Fri 29 Apr     , Andrew Victor wrote:
> For supporting multiple AT91 processors in a single kernel image, the
> base-address of the system peripherals is processor-dependent.  The GPIO
> driver should therefore not reference AT91_VA_BASE_SYS, but rather the
> correct peripheral base-address needs to be provided by the
> processor-specific initialization code.
please don't I swtich to early device and clkdev thye are in confilt
and this is clean inside

Best Regards,
J.
