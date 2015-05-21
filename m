From: jonathar@broadcom.com (Jonathan Richardson)
Date: Thu, 21 May 2015 10:48:32 -0700
Subject: [PATCH 2/2] misc: Add initial Digital Timing Engine (DTE) driver
 for cygnus
In-Reply-To: <20150521063303.GA1558@localhost.localdomain>
References: <5543CD73.2030902@broadcom.com>
 <20150501203004.3add2c95@lxorguk.ukuu.org.uk> <9193036.7UYD2OGJHk@wuerfel>
 <554D1649.2030106@broadcom.com> <20150513153544.GC2065@localhost.localdomain>
 <5553AAEA.30503@broadcom.com> <20150513202716.GA15878@localhost.localdomain>
 <5553DD7D.8090905@broadcom.com> <20150514113054.GB1580@localhost.localdomain>
 <555D1ADA.8070308@broadcom.com> <20150521063303.GA1558@localhost.localdomain>
Message-ID: <555E1A70.90305@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15-05-20 11:33 PM, Richard Cochran wrote:
> On Wed, May 20, 2015 at 04:38:02PM -0700, Jonathan Richardson wrote:
>>
>> Richard, this design isn't going to work. We need to have both kernel
>> and user space consumers.
> 
> But you did not implement even a single kernel consumer.
> 
>> We don't want all GPIO's in a common timestamp
>> buffer either, as it presents problems I mentioned previously. Currently
>> the network input is a gpio.
> 
> That won't work.  Consider what happens when the MAC drops a packet.
> 
>> After some discussion here I think we'll
>> have to keep this driver out of the kernel for now.
> 
> Fine with me.

We'll keep this discussion and try to figure out the best interface
keeping in mind what you've said as we move further along with it. Not a
wasted discussion. Requirements of this need to be better defined and
thought out also.

Thanks,
Jon

> 
> Thanks,
> Richard
> 
