From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 05 Nov 2012 11:59:05 -0700
Subject: [PATCH V4 REPOST] ARM: implement debug_ll_io_init()
In-Reply-To: <CAOesGMh84DVzwHd8z+fcLeSmcDoSm566MOXQYi2u7uX6S1t5Bg@mail.gmail.com>
References: <1351718515-871-1-git-send-email-swarren@wwwdotorg.org>
 <CAOesGMh84DVzwHd8z+fcLeSmcDoSm566MOXQYi2u7uX6S1t5Bg@mail.gmail.com>
Message-ID: <50980C79.8030101@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2012 10:37 AM, Olof Johansson wrote:
> On Wed, Oct 31, 2012 at 10:21 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
>> Arnd, Olof, could this patch be placed into a standalone topic branch in
>> arm-soc branch; I'd like to make use of this patch for both Tegra and
>> bcm2835 this cycle, and perhaps others might too. Thanks.
> 
> Done, applied to single-patch branch devel/debug_ll_init. I'll bring
> that in at next/multiplatform as well.

Thanks very much. I've merged this into the Tegra tree.
