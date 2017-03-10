From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 10 Mar 2017 09:44:42 -0800
Subject: [PATCH 1/2] ARM: dts: BCM53573: Don't use nonexistent
 "default-off" LED trigger
In-Reply-To: <20170310132049.GC11875@amd>
References: <20170308064105.26619-1-zajec5@gmail.com>
 <42bce8ea-f1dc-2018-33f1-d296ccd7b677@gmail.com> <20170310132049.GC11875@amd>
Message-ID: <3414f628-6b78-dc5a-4abf-ec5f40e7a4ee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/2017 05:20 AM, Pavel Machek wrote:
> On Wed 2017-03-08 09:31:44, Florian Fainelli wrote:
>> On 03/07/2017 10:41 PM, Rafa? Mi?ecki wrote:
>>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>>>
>>> Such a trigger doesn't exist in Linux and is not needed as LED is being
>>> turned off by default. This could cause errors in LEDs core code when
>>> trying to set default trigger.
>>>
>>> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
>>
>> Since you are fixing something, what's the proper Fixes: tag for this
>> commit? Likewise for the second patch.
> 
> Lets not make submitting patches any harder than it already is.

If it was fixing something that was already in Linus' tree, it's
important to know so I can queue the patch for the appropriate pull
request targeting e.g: v4.11-rcX, this is not needed here as Rafal later
indicated.
-- 
Florian
