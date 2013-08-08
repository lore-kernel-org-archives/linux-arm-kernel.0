From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 08 Aug 2013 17:30:02 +0200
Subject: [PATCH 1/3] i2c-mv64xxx: Add I2C Transaction Generator support
In-Reply-To: <20130807155700.GE19280@titan.lakedaemon.net>
References: <1373898278-4805-1-git-send-email-gregory.clement@free-electrons.com>
 <1373898278-4805-2-git-send-email-gregory.clement@free-electrons.com>
 <20130716080503.GA3125@lukather> <5200E684.5080003@free-electrons.com>
 <20130807143546.GD2978@katana> <20130807155700.GE19280@titan.lakedaemon.net>
Message-ID: <5203B97A.8060605@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2013 17:57, Jason Cooper wrote:
> On Wed, Aug 07, 2013 at 04:35:46PM +0200, Wolfram Sang wrote:
>>
>>> But we shouldn't use it alone: we should always use:
>>> compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
>>>
>>> From my point of view using  "marvell,mv78230-i2c" alone is an error.
>>>
>>> Wolfram what is your opinion on it?
>>
>> It is not strictly an error, but risky. If you use an older Kernel
>> version (or other OS) which only offers "mv64xxx" you will have no
>> match. Although the driver theoretically could have basic support for
>> all mv64xxx variants skipping all additional features of later IP
>> revisions.
> 
> I agree here.  The driver is advertising what IP blocks it can handle,
> so it makes sense to add both strings since it can handle both.

Wolfram,
so beside remarks about the compatibility strings. I didn't any other
comment since the v3 which was 7 weeks ago.

Does it mean that once I will have added the handle of this string,
you will be able to take the series for the 3.12 kernel?

Thanks,

> 
> thx,
> 
> Jason.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
