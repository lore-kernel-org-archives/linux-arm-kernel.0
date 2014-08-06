From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Aug 2014 13:43:29 +0100
Subject: [PATCH v2 1/3] arm64: fix typo in I-cache policy detection
In-Reply-To: <1407230757-15305-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1407230757-15305-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140806124329.GL25953@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 05, 2014 at 10:25:55AM +0100, Ard Biesheuvel wrote:
> This removes an unfortunately placed semi-colon resulting in all instruction
> caches being classified as AIVIVT.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> ---
> v2: add ack

Cheers Ard, I'll take this patch into our fixes branch.

Will
