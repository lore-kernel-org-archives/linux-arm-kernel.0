From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 16 Jul 2015 17:52:53 +0200
Subject: [PATCH v4 0/2] arm/arm64: KVM: Optimize arm64 fp/simd, saves
 30-50% on exits for non-VHE
In-Reply-To: <1436577547-5646-1-git-send-email-m.smarduch@samsung.com>
References: <1436577547-5646-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <20150716155253.GU7845@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 06:19:05PM -0700, Mario Smarduch wrote:
> This is a followp to previous iteration but implemented on top of VHE patches. 
> Only non-VHE path is addressied by this patch. In second patch 32-bit handler 
> is updated to keep exit handling consistent with 64-bit code, and nothing
> has changed.
> 
Why not simply preserve this the way it was in v3 and have it merged
first - after all we have reviewed it and I thought it was more or less
ready to be merged - I suspect the VHE patches may have a way to go
still ?

-Christoffer
