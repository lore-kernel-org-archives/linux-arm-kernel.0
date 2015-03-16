From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Mar 2015 10:58:39 +0000
Subject: [PATCH] arm64: put __boot_cpu_mode label after alignment instead
 of before
In-Reply-To: <20150316105206.GB15066@leverpostej>
References: <1426260078-20720-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150316105206.GB15066@leverpostej>
Message-ID: <20150316105839.GE15066@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 10:52:07AM +0000, Mark Rutland wrote:
> On Fri, Mar 13, 2015 at 03:21:18PM +0000, Ard Biesheuvel wrote:
> > Another one for the big head.S spring cleaning: the label should
> > be after the .align or it may point to the padding.
> > 
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> Given I managed to produce the exact same patch, this obviously looks
> good to me:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

... and now I disocver this is already in v4.0-rc4.

Never mind :)

Mark.
