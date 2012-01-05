From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 5 Jan 2012 21:12:43 +0530
Subject: [PATCH 1/2] PM / Domains: Add OF support
In-Reply-To: <201201032330.58602.rjw@sisk.pl>
References: <1323704789-23923-1-git-send-email-thomas.abraham@linaro.org>
 <201112282317.54291.rjw@sisk.pl>
 <CAJuYYwQp7gfuovd8kKEe_D+ACyq4OafxZRW_G=U_9zCMOy+prA@mail.gmail.com>
 <201201032330.58602.rjw@sisk.pl>
Message-ID: <CAJuYYwT6bKgqn5y62Pi4Z3wyWq=1HtxtOMOv8kEUZs3kD3HR9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On 4 January 2012 04:00, Rafael J. Wysocki <rjw@sisk.pl> wrote:
[...]

>> The 'struct device_node' is a representation of a instance of a device
>> tree node. It can represent nodes that are not devices. Hence, it can
>> be used to represent a power domain in a device tree and also included
>> in the 'struct generic_pm_domain'.
>
> OK, so please address my second comment regarding the $subject patch,
> i.e. that you might add a wrapper around the original
> __pm_genpd_add_device() instead of modifying __pm_genpd_add_device()
> itself.

Thanks. I will prepare and submit the updated patch.

Regards,
Thomas.

>
> Thanks,
> Rafael
