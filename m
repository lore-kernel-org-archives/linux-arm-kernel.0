From: steve.capper@arm.com (Steve Capper)
Date: Fri, 7 Sep 2018 15:13:06 +0100
Subject: [PATCH V3 0/8] 52-bit kernel VAs for arm64
In-Reply-To: <a1947a09-39a1-5911-d5ef-7390f49ce7ce@redhat.com>
References: <20180510162347.3858-1-steve.capper@arm.com>
 <a1947a09-39a1-5911-d5ef-7390f49ce7ce@redhat.com>
Message-ID: <20180907141305.dwuwxj22vyqtbq4m@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2018 at 02:25:49AM -0400, Jon Masters wrote:
> On 05/10/2018 12:23 PM, Steve Capper wrote:
> 
> > This patch series brings 52-bit kernel VA support to arm64; if supported
> > at boot time. A new kernel option CONFIG_ARM64_VA_BITS_52 is available
> > when configured with a 64KB PAGE_SIZE (as on ARMv8.2-LPA, 52-bit VAs are
> > only allowed when running with a 64KB granule).
> 
> What's the plan with this series?
>

Hi Jon,
The series is quite heavyweight in that it affects quite a few subtle
areas of the kernel.

Catalin can better comment, but my understanding is that the plan is to
hold off expanding the kernel VA space until strictly necessary.

Cheers,
-- 
Steve
