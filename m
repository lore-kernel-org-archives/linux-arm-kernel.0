From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 07 Jun 2013 16:27:33 +0100
Subject: [PATCH 0/2] MCPM backend for Virtual Express TC2
In-Reply-To: <1370587152-4630-1-git-send-email-nicolas.pitre@linaro.org>
References: <1370587152-4630-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1370618853.4852.28.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-06-07 at 07:39 +0100, Nicolas Pitre wrote:
> This is the MCPM backend enabling SMP secondary boot and CPU hotplug
> on the VExpress TC2 big.LITTLE platform.  The method to allow CPU suspend
> is also implemented.

With my Naming Purist (TM) hat on, I must point out that there is no
such thing as TC2... The platform you're referring to is V2P-CA15_A7.
TC2 is just an internal name for the chip (as in: Test Chip 2, which
followed 1 and was supposed to be followed by 3 ;-). And considering the
fact that substantial part of the power management system lives outside
of the main chip anyway, the naming is not really precise.

Now, I appreciate that "v2p_ca15_a7_" namespace is a bit cumbersome
comparing to "tc2_" and no, I don't really have better ideas now...

Other than that:

Acked-by: Pawel Moll <pawel.moll@arm.com>

Cheers!

Pawe?
