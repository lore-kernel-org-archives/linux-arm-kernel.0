From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Oct 2014 09:35:09 +0100
Subject: FP register corruption in Exynos 4210 (Cortex-A9)
In-Reply-To: <5434F387.804@gmail.com>
References: <54345FA7.9030606@gmail.com>
 <20141007221515.GY5182@n2100.arm.linux.org.uk> <5434F387.804@gmail.com>
Message-ID: <20141008083509.GD5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 05:19:19AM -0300, Lanchon wrote:
> for instance, you say that if an ISR uses the FPU it would corrupt user  
> FP state. fine, but it is not that simple. what if the FPU was disabled  
> at the time of interrupt? (ie: lazy restore did not yet happen in this  
> time-slice.)

At that point, it depends on which kernel version you are using.  Yes,
older kernels will just restore the state.  Newer kernels will trap this
and complain.

> a plausible answer (which i am making up out of the blue) would be:

If you want to continue asking questions and getting answers, change
your attitude; I am not a child.

You should also consider *not* writing essays, but instead ask clear,
direct and to the point questions - in other words, short emails.  Not
everyone has the time or the patience to read huge long emails, or
huge rambling threads of 50+ pages on web forums.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
