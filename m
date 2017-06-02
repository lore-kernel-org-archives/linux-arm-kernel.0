From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Fri, 2 Jun 2017 14:29:32 +0200
Subject: [PATCH 4/4] drm/bridge: dw-hdmi: add cec driver
In-Reply-To: <20170602120702.GM22219@n2100.armlinux.org.uk>
References: <20170530142218.GS22219@n2100.armlinux.org.uk>
 <E1dFi3P-0004lv-2K@rmk-PC.armlinux.org.uk>
 <db1f1785-930b-0f32-d71a-79ae8e053b2c@xs4all.nl>
 <20170602120702.GM22219@n2100.armlinux.org.uk>
Message-ID: <de82fd55-4838-b3bb-7c82-5bf7c84c8d24@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/17 14:07, Russell King - ARM Linux wrote:
> On Thu, Jun 01, 2017 at 10:31:10AM +0200, Hans Verkuil wrote:
>> This will change. Patches to fix the config handling are pending for 4.12.
>>
>> Here you can see the pending patches:
>> https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=drm-cec
>>
>> The patches from 'cec-notifier.h: handle unreachable CONFIG_CEC_CORE' to
>> 'cec: drop MEDIA_CEC_DEBUG' should all be merged in 4.12.
> 
> Hi Hans,
> 
> I'll wait until these have hit mainline before generating another
> patch series.  Do you have any idea when that might happen?

rc6? Hard to tell, I know Mauro is very busy so it can be difficult to
predict.

Regards,

	Hans
