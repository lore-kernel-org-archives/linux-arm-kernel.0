From: jcm@redhat.com (Jon Masters)
Date: Fri, 7 Sep 2018 02:25:49 -0400
Subject: [PATCH V3 0/8] 52-bit kernel VAs for arm64
In-Reply-To: <20180510162347.3858-1-steve.capper@arm.com>
References: <20180510162347.3858-1-steve.capper@arm.com>
Message-ID: <a1947a09-39a1-5911-d5ef-7390f49ce7ce@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2018 12:23 PM, Steve Capper wrote:

> This patch series brings 52-bit kernel VA support to arm64; if supported
> at boot time. A new kernel option CONFIG_ARM64_VA_BITS_52 is available
> when configured with a 64KB PAGE_SIZE (as on ARMv8.2-LPA, 52-bit VAs are
> only allowed when running with a 64KB granule).

What's the plan with this series?

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
