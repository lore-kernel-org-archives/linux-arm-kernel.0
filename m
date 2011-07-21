From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Thu, 21 Jul 2011 20:54:56 +0530
Subject: [PATCHV3 2/4] OMAP: I2C: Remove the reset in the init path
In-Reply-To: <20110721135938.GC30943@legolas.emea.dhcp.ti.com>
References: <1311256381-25548-1-git-send-email-shubhrajyoti@ti.com>
	<1311256381-25548-3-git-send-email-shubhrajyoti@ti.com>
	<20110721135938.GC30943@legolas.emea.dhcp.ti.com>
Message-ID: <4E2844C8.9010306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 July 2011 07:29 PM, Felipe Balbi wrote:
> Hi,
>
> On Thu, Jul 21, 2011 at 07:22:59PM +0530, Shubhrajyoti D wrote:
>> The reset in the driver at init is not needed
>> anymore as the hwmod framework takes care of
>> reseting it.
>>
>> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
> this is still doing two things:
>
> a. remove the reset from init path
> b. add and use ->device_reset() when needed.
Yes agree ,  will add it.
