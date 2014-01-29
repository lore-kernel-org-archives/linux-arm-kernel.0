From: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 29 Jan 2014 09:16:24 -0800
Subject: [PATCH 3/5] x86: align x86 arch with generic CPU modalias handling
In-Reply-To: <1391014246-9715-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1391014246-9715-1-git-send-email-ard.biesheuvel@linaro.org>
 <1391014246-9715-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <52E93768.5000103@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2014 08:50 AM, Ard Biesheuvel wrote:
> The x86 CPU feature modalias handling existed before it was reimplemented
> generically. This patch aligns the x86 handling so that it
> (a) reuses some more code that is now generic;
> (b) uses the generic format for the modalias module metadata entry, i.e., it
>     now uses 'cpu:type:x86,venVVVVfamFFFFmodMMMM:feature:,XXXX,YYYY' instead of
>     the 'x86cpu:vendor:VVVV:family:FFFF:model:MMMM:feature,XXXX,YYYY' that was
>     used before.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Looks good, although I have not tested it.

Acked-by: H. Peter Anvin <hpa@linux.intel.com>

	-hpa
