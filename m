From: brian.starkey@arm.com (Brian Starkey)
Date: Wed, 17 Feb 2016 10:07:34 +0000
Subject: [RESEND2 PATCH 1/3] memremap: add MEMREMAP_WC flag
In-Reply-To: <20160217004351.GE3037@kroah.com>
References: <cover.1454950917.git.brian.starkey@arm.com>
 <9085d37fa97a762a46b9d58719c085368682c64f.1454950917.git.brian.starkey@arm.com>
 <20160208183006.GA8429@kroah.com>
 <20160209091501.GA23507@e106950-lin.cambridge.arm.com>
 <20160216111426.GA22133@e106950-lin.cambridge.arm.com>
 <20160217004351.GE3037@kroah.com>
Message-ID: <20160217100734.GC22133@e106950-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 04:43:51PM -0800, Greg Kroah-Hartman wrote:
>On Tue, Feb 16, 2016 at 11:14:26AM +0000, Brian Starkey wrote:
>> Hi Greg,
>>
>> Is the documentation OK? Is there any chance of you picking up this
>> series?
>>
>> I can rebase onto -next if that's the right place, but they still apply
>> on 4.5-rc4 and fix a panic, so I thought perhaps they could make 4.5.
>
>I think memory stuff like this goes through Andrew's tree, not mine...

Right, fair enough. I was just blindly working off get_maintainer.pl

Cheers,

Brian
>
>thanks,
>
>greg k-h
>
