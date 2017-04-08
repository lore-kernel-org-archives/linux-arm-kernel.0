From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 8 Apr 2017 18:25:48 +0200
Subject: [PATCH v3 5/9] arm, arm64: factorize common cpu capacity default
 code
In-Reply-To: <20170327131825.32134-6-juri.lelli@arm.com>
References: <20170327131825.32134-1-juri.lelli@arm.com>
 <20170327131825.32134-6-juri.lelli@arm.com>
Message-ID: <20170408162548.GA18881@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 02:18:21PM +0100, Juri Lelli wrote:
> arm and arm64 share lot of code relative to parsing CPU capacity
> information from DT, using that information for appropriate scaling and
> exposing a sysfs interface for chaging such values at runtime.
> 
> Factorize such code in a common place (driver/base/arch_topology.c) in
> preparation for further additions.
> 
> Suggested-by: Will Deacon <will.deacon@arm.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>

I need some acks here from the arm maintainers before I can take this
series...

thanks,

greg k-h
