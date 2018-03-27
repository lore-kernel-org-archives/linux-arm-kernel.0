From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 27 Mar 2018 08:44:21 -0700
Subject: [PATCH script] hwmon: Use octal not symbolic permissions
In-Reply-To: <1522151285.12357.78.camel@perches.com>
References: <1522096136.12357.21.camel@perches.com>
 <9b112651-d0cf-5f3b-b643-3328028a95cd@roeck-us.net>
 <1522136107.12357.58.camel@perches.com>
 <5ec8703b-2979-7a1d-fbc3-bd528d7a5e29@roeck-us.net>
 <1522151285.12357.78.camel@perches.com>
Message-ID: <9e908abe-2dc8-dbba-97f9-d9614fa4b199@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2018 04:48 AM, Joe Perches wrote:
> On Tue, 2018-03-27 at 03:28 -0700, Guenter Roeck wrote:
>> On 03/27/2018 12:35 AM, Joe Perches wrote:
>>> On Mon, 2018-03-26 at 23:33 -0700, Guenter Roeck wrote:
>>>> Since the hwmon subsystem has been labeled as both "obsolete" and "obscure",
>>>
>>> fyi: It's marked Maintained in MAINTAINERS
>>>
>>
>> I did not say that it was not maintained, and I am aware of the information
>> in the MAINTAINERS file, thanks.
> 
> As am I.
> 
> I do agree that hwmon is obscure.  Almost everything about
> anything is obscure to those that don't fully understand it.
> 
> I am unaware though of any use of "obsolete" in drivers/hwmon/
> or in Documentation/ about hwmon or the wiki/
> 
> In what sense do you mean hwmon is obsolete?
> 

_I_ did not say it was obsolete. It was described as obsolete by a maintainer
of a different subsystem at a conference a couple of years ago. If I wasn't too
lazy, I could try to find the presentation, but I don't see the point.

> And the cocci script?
> 
> Anything later than:
> https://systeme.lip6.fr/pipermail/cocci/2016-December/003887.html
> https://github.com/groeck/coccinelle-patches/tree/master/hwmon
> ?
> 
I don't think I ever published it. If I recall correctly, it required
some cleanup patches to be applied first, but then I gave up on the idea
because I didn't want to proceed without code reviews.

> btw: I think the perl scripts I posted for DEV_ATTR_<RW|RO|WO>
> transforms are simpler and less prone to tool versioning
> issues.
> 
> https://lkml.org/lkml/2017/12/22/844
> 
> It'd be fairly simple to add SENSOR_ support.
> 

I'll keep it in mind.

Thanks,
Guenter
