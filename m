From: rogerq@ti.com (Roger Quadros)
Date: Thu, 20 Jun 2013 15:30:18 +0300
Subject: [RFC PATCH 2/6] mfd: omap-usb-host: Put pins in IDLE state on
 suspend
In-Reply-To: <878v26815g.fsf@linaro.org>
References: <1371650753-11452-1-git-send-email-rogerq@ti.com>
 <1371650753-11452-3-git-send-email-rogerq@ti.com> <878v26815g.fsf@linaro.org>
Message-ID: <51C2F5DA.1010904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2013 08:23 PM, Kevin Hilman wrote:
> Hi Roger,
> 
> Roger Quadros <rogerq@ti.com> writes:
> 
>> In order to support wake up from suspend use the pinctrl
>> framework to put the USB host pins in IDLE state during suspend.
>>
>> CC: Samuel Ortiz <sameo@linux.intel.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> You should use helpers for this now in the pinctrl core:
> 
>     http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/173514.html
>

Right. thanks.

cheers,
-roger
