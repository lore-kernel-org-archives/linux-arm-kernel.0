From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 11 Jan 2015 19:29:41 +0100
Subject: [PATCH 7/7] arm64: kvm: decode ESR_ELx.EC when reporting
 exceptions
In-Reply-To: <1420632260-8798-8-git-send-email-mark.rutland@arm.com>
References: <1420632260-8798-1-git-send-email-mark.rutland@arm.com>
 <1420632260-8798-8-git-send-email-mark.rutland@arm.com>
Message-ID: <20150111182941.GN21444@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 12:04:20PM +0000, Mark Rutland wrote:
> To aid the developer when something triggers an unexpected exception,
> decode the ESR_ELx.EC field when logging an ESR_ELx value using the
> newly introduced esr_get_class_string. This doesn't tell the developer
> the specifics of the exception encoded in the remaining IL and ISS bits,
> but it can be helpful to distinguish between exception classes (e.g.
> SError and a data abort) without having to manually decode the field,
> which can be tiresome.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
