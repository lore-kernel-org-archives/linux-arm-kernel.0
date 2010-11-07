From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Sun, 7 Nov 2010 10:27:39 -0600
Subject: [PATCH 6/6] omap: iommu: code reorganization and cleanup
In-Reply-To: <4CD5C88E.5050009@ti.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
	<1289006396-27230-7-git-send-email-omar.ramirez@ti.com>
	<4CD5C88E.5050009@ti.com>
Message-ID: <AANLkTimt5YcOFKasa-q4ybpfTGh7361VpUjPOFa3a_ee@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 6, 2010 at 4:28 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> On 11/5/2010 9:19 PM, Ramirez Luna, Omar wrote:
>>
>> Since omap-iommu is now using hwmod, there are structures and
>> arrays that can be cleaned up to increase the readability of
>> the code.
>
> This patch should be merged with the previous one as well.

No problem.

> I do not see the need to split in 3 patches these changes.
> It will be much readable and will avoid people, like me, doing comment on a
> piece of code you will remove 2 patches later.
> That cleanup must be done when the hwmod is introduced since that code was
> already useless at that time.

Yes, I was trying to avoid mixing changes so the review could be
focused on the replacements only, it seems it backfired.

Will do it in one patch and see how it looks.

>> +static char *omap4_devices[] = {
>> + ? ? ? "ducati",
>> + ? ? ? "tesla",
>> + ? ? ? NULL,
>
> Not needed if you iterate over the class.

Ok.

Regards,

Omar
