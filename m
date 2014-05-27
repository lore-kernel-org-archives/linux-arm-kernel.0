From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 27 May 2014 10:07:01 -0400
Subject: [GIT PULL] ARM: Keystone reset driver 3.16
In-Reply-To: <1401175584.4090.22.camel@paszta.hi.pengutronix.de>
References: <1400880597-7516-1-git-send-email-santosh.shilimkar@ti.com>	
 <20140526212605.GQ27093@quad.lixom.net>
 <1401175584.4090.22.camel@paszta.hi.pengutronix.de>
Message-ID: <53849C05.8090004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

On Tuesday 27 May 2014 03:26 AM, Philipp Zabel wrote:
> Hi Olof, Santosh,
> 
> Am Montag, den 26.05.2014, 14:26 -0700 schrieb Olof Johansson:
>> On Fri, May 23, 2014 at 05:29:57PM -0400, Santosh Shilimkar wrote:
>>> Hi Arm-soc folks,
>>>
>>> Please pull below keystone reset driver for 3.16 . To avoid merge conflict
>>> with earlier keystone-soc pull request[1], I have based the subject pull
>>> request on top of it. It merges cleanly with arm-soc 'next/soc2' head. Please
>>> apply it against 'next/soc2'. Thanks 
>>
>> Hi,
>>
>> I notice this driver doesn't have an ack from Philipp Zabel (cc:d here). That
>> would be appropriate.
>
We asked about ack, split series options from reset folks but didn't hear back.
Since the series has been on the list for almost 3 merge windows now, I asked
Arnd how to go about it and he suggested to send it via arm-soc. Should have
clarified it in pull request.

 
> I don't think this driver needs my ack, see below, ...
> 
>> (Philipp, should there be a MAINTAINERS entry for you so
>> that get_maintainer works as expected here?)
> 
> ... but that is a good idea to keep me in the loop. I will send a patch.
> 
>> I'd also prefer to see the driver and the other changes split up since we tend
>> to merge them through different branches. I think it's OK to just split in
>> those two for this merge.
>>
Agree. I have split the series and created another two tags as below. If you
are ok, please pull them accordingly. If you want me to repost the pull requests
in separate emails, I can do that as well. Do let me know.

1] Reset driver. Contains only driver and binding documentation.

git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
tags/keystone-reset-driver

2]Keystone mach updates which needs to applied on top of earlier soc
pull request. i.e on top of arm-soc 'next/soc2'. I have left 1 dts
patch in the same instead of creating another pull request for dts
change. 

git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
tags/keystone-soc-2

Regards,
Snatosh
