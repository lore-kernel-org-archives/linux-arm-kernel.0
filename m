From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 27 Nov 2013 09:17:08 -0500
Subject: [PATCH] watchdog: davinci: rename platform driver to davinci-wdt
In-Reply-To: <5295FB0E.4070406@ti.com>
References: <1385559113-4354-1-git-send-email-ivan.khoronzhuk@ti.com>
 <5295FB0E.4070406@ti.com>
Message-ID: <5295FEE4.8090108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 November 2013 09:00 AM, Sekhar Nori wrote:
> On Wednesday 27 November 2013 07:01 PM, Ivan Khoronzhuk wrote:
>> As we switch to use the watchdog core which permits more than one
>> active watchdog in the system, rename platform driver to
>> "davinci-wdt" to be identifiable.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> 
> Looks good to me. Since bulk of this patch touches mach-davinci, I would
> like to take this through my tree to avoid conflicts with other
> mach-davinci patches I accept.
> 
Sounds good. Thanks Sekhar !!

Regards,
Santosh
