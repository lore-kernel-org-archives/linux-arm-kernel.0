From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 6 Jan 2012 17:37:17 +0100
Subject: [PATCH 1/3] ARM: OMAP2+: kconfig: Enable devicetree by default
 for OMAP2+ systems
In-Reply-To: <CACxGe6sAEs4H4FR75psy74x9V3mbp6wAdryJbDu8HBZ4tMmyvw@mail.gmail.com>
References: <1323190149-6492-2-git-send-email-b-cousson@ti.com>
 <CACxGe6sAEs4H4FR75psy74x9V3mbp6wAdryJbDu8HBZ4tMmyvw@mail.gmail.com>
Message-ID: <4F07233D.5000001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/4/2012 9:11 PM, Grant Likely wrote:
> On Tue, Dec 6, 2011 at 9:49 AM, Benoit Cousson<b-cousson@ti.com>  wrote:
>> devicetree will become the mandatory boot method for OMAP2+.
>> In order to avoid cluttering the OMAP code with #ifdef CONFIG_OF,
>> select USE_OF by default for every OMAP2+ systems.
>> Select as well the APPENDED_DTB and ATAG_DTB_COMPAT to allow legacy
>> boot loader to keep working properly.
>>
>> Enable PROC_DEVICETREE as well.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Tony Lindgren<tony@atomide.com>
>
> Acked-by: Grant Likely<grant.likely@secretlab.ca>

Thanks for the reviews.

Benoit
