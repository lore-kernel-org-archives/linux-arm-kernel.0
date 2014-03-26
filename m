From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Mar 2014 11:01:41 +0000
Subject: [PATCH V2 0/3] PTE fixes for arm and arm64
In-Reply-To: <20140326102317.GA26040@linaro.org>
References: <1393328334-27285-1-git-send-email-steve.capper@linaro.org>
 <20140326102317.GA26040@linaro.org>
Message-ID: <20140326110141.GY7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 10:23:19AM +0000, Steve Capper wrote:
> If there are no objections, I was going to put the following into
> Russell's patch system:
> 	arm: mm: Double logical invert for pte accessors
> 	arm: mm: Switch back to L_PTE_WRITE

I'm not all that happy with double inversions - I think they just serve
to cause confusion (and it was confusing, which is why I removed it.)
I'll only take them if you have a really good reason why you want to
bring it back.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
