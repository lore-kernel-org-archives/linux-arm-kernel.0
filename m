From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Fri, 19 Aug 2016 08:03:29 +0200
Subject: [PATCH v3 3/4] media: Add Mediatek MDP Driver
In-Reply-To: <1471586051.1540.11.camel@mtksdaap41>
References: <1470751137-12403-1-git-send-email-minghsiu.tsai@mediatek.com>
 <1470751137-12403-4-git-send-email-minghsiu.tsai@mediatek.com>
 <861e5c51-1333-fdc7-2793-d4741a48c72f@xs4all.nl>
 <1471586051.1540.11.camel@mtksdaap41>
Message-ID: <2d18a4ee-69e6-e400-22b6-b3867b91b5c0@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2016 07:54 AM, Minghsiu Tsai wrote:
> On Mon, 2016-08-15 at 14:55 +0200, Hans Verkuil wrote:
>> On 08/09/2016 03:58 PM, Minghsiu Tsai wrote:
>> This isn't right. For VIDEO_CAPTURE you support the COMPOSE targets, and for
>> the VIDEO_OUTPUT you support the CROP targets. Right now I can use e.g. TGT_CROP
>> with VIDEO_CAPTURE, which isn't correct.
>>
>> s_selection has the same problem.
>>
> 
> So my understanding is
> VIDEO_OUTPUT -> only allow to use target XXX_CROP_XXX
> VIDEO_CAPTURE -> only allow to use target XXX_COMPOSE_XXX
> 
> Am I right?

Correct.

Regards,

	Hans
