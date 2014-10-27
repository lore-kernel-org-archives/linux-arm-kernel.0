From: matt.fleming@intel.com (Matt Fleming)
Date: Mon, 27 Oct 2014 17:45:27 +0000
Subject: [PATCH 00/10] arm64 EFI patches for 3.19
In-Reply-To: <CAKv+Gu_0uobUr2Ytzg7p8W4akK-c=qnFxhzuy4mbgfxnKjBG2Q@mail.gmail.com>
References: <1413987713-30528-1-git-send-email-ard.biesheuvel@linaro.org>
 <20141027115055.GM8768@arm.com>
 <CAKv+Gu_0uobUr2Ytzg7p8W4akK-c=qnFxhzuy4mbgfxnKjBG2Q@mail.gmail.com>
Message-ID: <1414431927.7122.471.camel@mfleming-mobl1.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-10-27 at 13:03 +0100, Ard Biesheuvel wrote:
> 
> Yeah, I was struggling a bit with that. I think the agreement was that
> everything EFI related goes through Matt's tree, but I don't think
> that necessarily makes sense for patches that only touch arch/arm64,
> unless there are interdependencies with the generic code.
> 
> From this series, only patches #7 and #8 need to go through Matt's
> tree, and even if #9 and #10 are also related to SMBIOS, they are in
> fact orthogonal to #7 and #8, so those can still go through the arm64
> tree without any merge order issues later on.
> 
> @Matt: any thoughts?

In this case, if it makes things easier for you folks in terms of
dependencies to take this *all* through the arm64 tree, that seems
sensible to me.
