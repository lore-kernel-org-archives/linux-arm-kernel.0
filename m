From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 23 Aug 2014 10:20:15 -0700
Subject: [PATCH v7 02/11] power/restart: Call machine_restart instead
 of arm_pm_restart
In-Reply-To: <20140821203904.GA26620@earth.universe>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
 <1408495538-27480-3-git-send-email-linux@roeck-us.net>
 <20140821203904.GA26620@earth.universe>
Message-ID: <53F8CD4F.7030609@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2014 01:39 PM, Sebastian Reichel wrote:
> Hi,
>
> On Tue, Aug 19, 2014 at 05:45:29PM -0700, Guenter Roeck wrote:
>> machine_restart is supported on non-ARM platforms, and and ultimately calls
>> arm_pm_restart, so dont call arm_pm_restart directly but use the more
>> generic function.
>>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>
> Acked-by: Sebastian Reichel <sre@kernel.org>
>
> Do you want me to take the patch via battery-2.6.git?
>

Hi Sebastian,

thanks a lot for the Ack. I am not sure if it is better to submit all
patches together or through individual maintainer trees. Let's wait for
Andrew's suggestion how we should proceed.

Thanks,
Guenter
