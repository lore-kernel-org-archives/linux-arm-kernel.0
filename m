From: dianders@chromium.org (Doug Anderson)
Date: Fri, 1 Aug 2014 21:57:42 -0700
Subject: [PATCH v6 00/10] ARM: dts: exynos: Prepare Spring
In-Reply-To: <53DC4E41.4050200@collabora.co.uk>
References: <1406940750-15880-1-git-send-email-afaerber@suse.de>
 <53DC4E41.4050200@collabora.co.uk>
Message-ID: <CAD=FV=V_vXZLMaTMFdgr62=zRXucZA6D3PvS0Mb40he0ShHTfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 1, 2014 at 7:34 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Hello Andreas
>
> On 08/02/2014 02:52 AM, Andreas F?rber wrote:
>>
>> Based on the preinstalled 3.8 based ChromeOS kernel and previous 3.15
>> based attempts by Stephan and me that broke for 3.16, I've prepared a
>> device tree for the HP Chromebook 11 aka Google Spring.
>>
>> v6 renames a node and reverts dp_hpd.
>>
>> Not yet enabled are trackpad, Wifi and sound.
>>
>> My rebasing branch for testing is here:
>> https://github.com/afaerber/linux/commits/spring-next
>>
>> Regards,
>> Andreas
>>
>
> I made a comment on patch 05/10 but the rest of the series looks good to me. So
> for the remaining patches:
>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>
> NOTE: I thought that Tomasz Figa gave you his Reviewed-by on v5 for the whole
> series as well but I didn't see his tag on the v6 patches.

Yes, I thought that too.  I assume he's OK with the small changes you
made between v5 and v6.  In the very least his Reviewed-by could be
present on the patches that didn't change between the last two revs.

Given Javier's review and Tomasz's review and Vincent's comments, I'll
probably skip all the work of reviewing the rest of the series unless
someone really wants me to.  ;)

-Doug
