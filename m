From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Wed, 8 Oct 2014 14:07:52 +0545
Subject: [PATCH v9 1/2] ARM: exynos5: Add PMU support for 5420
In-Reply-To: <CABxcv==38sEFnpXaWoL6pvzyF7XH+DA55cP2MDPgfY=zBwxVUQ@mail.gmail.com>
References: <1412673723-15551-1-git-send-email-vikas.sajjan@samsung.com>
 <1412673723-15551-2-git-send-email-vikas.sajjan@samsung.com>
 <CABxcv==38sEFnpXaWoL6pvzyF7XH+DA55cP2MDPgfY=zBwxVUQ@mail.gmail.com>
Message-ID: <CAGm_ybgMUy7Y7v1HksCeaTJ0oMXGK+Csc3AL=4yJEaCH2HyFBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Tue, Oct 7, 2014 at 6:17 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> Hellos Vikas,
>
> On Tue, Oct 7, 2014 at 11:22 AM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
>> From: Abhilash Kesavan <a.kesavan@samsung.com>
>>
>> Adds intial PMU settings for exynos5420. This is required for
>> future S2R and Switching support.
>>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
>> ---
>>  arch/arm/mach-exynos/pmu.c      |  287 +++++++++++++++++++++++++++++++++++++++
>>  arch/arm/mach-exynos/regs-pmu.h |  227 +++++++++++++++++++++++++++++++
>>  2 files changed, 514 insertions(+)
>
> S2R is working on my Exynos5420 Peach Pit Chromebook with your series:
>
> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>


Thanks for testing.



> Best regards,
> Javier
