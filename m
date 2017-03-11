From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Sat, 11 Mar 2017 12:33:29 -0800
Subject: [PATCH v4 14/36] [media] v4l2-mc: add a function to inherit
 controls from a pipeline
In-Reply-To: <20170311202621.GA15777@localhost>
References: <1487211578-11360-15-git-send-email-steve_longerbeam@mentor.com>
 <20170302160257.GK3220@valkosipuli.retiisi.org.uk>
 <20170303230645.GR21222@n2100.armlinux.org.uk>
 <20170304131329.GV3220@valkosipuli.retiisi.org.uk>
 <a7b8e095-a95c-24bd-b1e9-e983f18061c4@xs4all.nl>
 <20170310120902.1daebc7b@vento.lan>
 <5e1183f4-774f-413a-628a-96e0df321faf@xs4all.nl>
 <20170311101408.272a9187@vento.lan>
 <20170311153229.yrdjmggb3p2suhdw@ihha.localdomain>
 <acfb5eca-ff00-6d57-339a-3322034cbdb3@gmail.com>
 <20170311202621.GA15777@localhost>
Message-ID: <83464fb5-4d2c-628c-bb32-b62e4b00614c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/11/2017 12:26 PM, Pavel Machek wrote:
> Hi!
>
>>>> I tend to agree with that.
>>>
>>> I agree as well.
>>>
>>> This is in line with how existing drivers behave, too.
>>
>>
>> Well, sounds like there is consensus on this topic. I guess I'll
>> go ahead and remove the control inheritance support. I suppose
>> having a control appear in two places (subdev and video nodes) can
>> be confusing.
>
> I guess that's way to go. It is impossible to change userland APIs
> once the patch is merged...

Ok, not including myself, it's now 4 in favor of removing, 1 against...

Steve
