From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 25 Jan 2017 20:39:43 +0100
Subject: [PATCH v4 3/4] arm64: Use __tlbi() macros in KVM code
In-Reply-To: <20170125155232.10277-3-cov@codeaurora.org>
References: <20170125155232.10277-1-cov@codeaurora.org>
 <20170125155232.10277-3-cov@codeaurora.org>
Message-ID: <20170125193943.GW15850@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 10:52:31AM -0500, Christopher Covington wrote:
> Refactor the KVM code to use the __tlbi macros, which will allow an errata
> workaround that repeats tlbi dsb sequences to only change one location.
> This is not intended to change the generated assembly and comparing before
> and after vmlinux objdump shows no functional changes.
> 
> Signed-off-by: Christopher Covington <cov@codeaurora.org>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
