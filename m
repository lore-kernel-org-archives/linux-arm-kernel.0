From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 23 Jun 2017 08:28:58 -0500
Subject: [PATCH] pinctrl: qcom: qdf2xxx: expose only some GPIO pins
In-Reply-To: <CACRpkdZeDjS_g27=1e7uCmFpjnqX+sDSu5G2VAuwFr_GJW1mug@mail.gmail.com>
References: <1498164850-4738-1-git-send-email-timur@codeaurora.org>
 <CACRpkdZeDjS_g27=1e7uCmFpjnqX+sDSu5G2VAuwFr_GJW1mug@mail.gmail.com>
Message-ID: <c3d6aecf-93e6-ef47-69c1-ef4ce7174a32@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/23/17 7:33 AM, Linus Walleij wrote:

>> Instead, the ACPI table now lists only specific GPIOs that are exposed
>> externally as generic GPIO pins.
> 
> The ACPI table or the device tree property "gpios" right?
> 
> (But maybe this system is only using ACPI.)

It's only ACPI.

> I think using "lsgpio" fron tools/gpio/lsgpio.c is better to inspect
> the available GPIOs.
> 
> If you haven't tested the GPIO tools, please try it out.

I was not aware of these tools.  I will try them out, thanks.



-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
