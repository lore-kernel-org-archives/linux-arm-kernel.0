From: zonque@gmail.com (Daniel Mack)
Date: Mon, 30 Jul 2012 19:07:08 +0200
Subject: [PATCH v2] USB: ohci-pxa27x: add DT bindings
In-Reply-To: <20120730170556.GA27462@kroah.com>
References: <1343633352-2414-1-git-send-email-zonque@gmail.com>
 <20120730170556.GA27462@kroah.com>
Message-ID: <5016BF3C.70901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.07.2012 19:05, Greg KH wrote:
> On Mon, Jul 30, 2012 at 09:29:12AM +0200, Daniel Mack wrote:
>> Add DT bindings to the ohci-pxa27x driver and some documentation.
>>
>> Successfully tested on a PXA3xx board.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> ---
>> Changes from v1:
>>  - renamed "mrvl" to "marvell"
>>
>> Greg, I think that would best go through your usb tree. Is that ok?
> 
> Ok, but it will have to wait until after 3.6-rc1 is out.

Sure, no hurries at all. The rest of the releated patches won't make it
to mainline before 3.7 anyway.


Thanks,
Daniel
