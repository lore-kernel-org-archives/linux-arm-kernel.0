From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 17 May 2018 10:08:25 +0100
Subject: [PATCH v9 02/12] drivers: base: cacheinfo: setup DT cache
 properties early
In-Reply-To: <20180517065449.GA13589@kroah.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180511235807.30834-3-jeremy.linton@arm.com>
 <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
 <20180517065449.GA13589@kroah.com>
Message-ID: <829ce0f6-0234-c0f1-0f30-7fbb36fa6049@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 17/05/18 07:54, Greg KH wrote:
> On Tue, May 15, 2018 at 12:15:08PM -0500, Jeremy Linton wrote:
>> Hi Greg,
>>
>> Have you had a chance to look at the cachinfo parts of this patch?
> 
> Nope :)
> 
> I didn't write that, and while it is dumped in the driver core section
> of the kernel, I know nothing about it. 

Sorry for that, I didn't find any better place at that time(neither
now), so I did put it there following topology :)

> If you get an ack from Sudeep for this, which you did, that's fine
> with me, merge away!
> 

Thanks, we plan to take it via ARM64, hence we needed your official
say(ACK) for that.

-- 
Regards,
Sudeep
