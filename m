From: khilman@ti.com (Kevin Hilman)
Date: Tue, 02 Aug 2011 16:14:54 -0700
Subject: Remaining omap pull requests
In-Reply-To: <20110713061634.GG5783@atomide.com>
References: <20110711114736.GX5783@atomide.com>
	<201107120016.12366.arnd@arndb.de>
	<20110713061634.GG5783@atomide.com>
Message-ID: <4E3884EE.3070507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 07/12/2011 11:16 PM, Tony Lindgren wrote:
> * Arnd Bergmann<arnd@arndb.de>  [110711 15:11]:
>> On Monday 11 July 2011, Tony Lindgren wrote:
>>> Hi Arnd,
>>>
>>> Below is a summary of the pending omap pull requests as there are still
>>> few branches pending.
>>>
>>> Can you please take a look and see what you can take of these for v3.1
>>> merge window?
>>>
>>> There's still quite a bit more code shrinkage, and the new code for 4460
>>> and PRCM related changes are badly needed.
>>
>> I've pulled everything now, please check if it looks ok to you.
>
> Thanks looks good to me.
>
>> I haven't really looked at the patches much, I hope that I have time
>> to at least do some test builds and take a very rough look at the
>> contents tomorrow.
>
> OK thanks.
>
>> Thanks for the detailed descriptions, and for splitting it
>> into good-sized series.
>
> Looks like I forgot the i2c driver changes that also should be
> merged by us. Those are acked by Ben Dooks, Kevin's pull request
> for that is at:
>
> http://marc.info/?l=linux-omap&m=131014213007667&w=2
>

I thought this was already pulled, but looking now I see that this was 
never pulled into the arm-soc tree.

Can you pull this for v3.1 please?

Kevin
