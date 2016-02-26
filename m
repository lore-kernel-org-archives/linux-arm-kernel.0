From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Fri, 26 Feb 2016 14:09:44 +0100
Subject: [PATCH v5 0/8] Add MT8173 Video Encoder Driver and VPU Driver
In-Reply-To: <56D03DE2.1090400@mm-sol.com>
References: <1456215081-16858-1-git-send-email-tiffany.lin@mediatek.com>
 <56CC1CAB.1060409@xs4all.nl> <56D03DE2.1090400@mm-sol.com>
Message-ID: <56D04E98.8040209@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2016 12:58 PM, Stanimir Varbanov wrote:
> Hi Hans,
> 
> <snip>
> 
>> Nice!
>>
>> Can you try 'v4l2-compliance -s'? Note that this may not work since I know
>> that v4l2-compliance doesn't work all that well with codecs, but I am
>> curious what the output is when you try streaming.
> 
> Sorry for the off topic question.
> 
> Does every new v4l2 encoder/decoder driver must use v4l2 mem2mem device
> framework, with other words is that mandatory?
> 

No, that's not mandatory. In most cases it will simplify your code, but
sometimes it only makes it harder and then you are better off doing it
yourself.

Regards,

	Hans
