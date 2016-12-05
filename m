From: james.morse@arm.com (James Morse)
Date: Mon, 05 Dec 2016 09:52:12 +0000
Subject: [stable:PATCH 0/3] PAN fixes backport for v4.4.35
In-Reply-To: <20161202172321.GA25426@kroah.com>
References: <20161202164247.19496-1-james.morse@arm.com>
 <20161202172321.GA25426@kroah.com>
Message-ID: <584538CC.50807@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 02/12/16 17:23, Greg KH wrote:
> On Fri, Dec 02, 2016 at 04:42:44PM +0000, James Morse wrote:
>> Hi linux-stable,
>>
>> This is the backport of the recent PAN fixes series for v4.4.35.
>> Original series:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-October/461806.html
> 
> Why just 4.4-stable?  What about 4.8-stable?

Patch 1 doesn't backport easily. I was going to do v4.8 next, but thought one at
a time would be the least confusing...

(I don't seem to be very good at predicting what is confusing!)


Thanks,

James
