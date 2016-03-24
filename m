From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 24 Mar 2016 16:47:52 +0900
Subject: [PATCH v6 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
In-Reply-To: <56F396FB.8030402@rock-chips.com>
References: <1458646525-491-1-git-send-email-andy.yan@rock-chips.com>
 <1458646592-540-1-git-send-email-andy.yan@rock-chips.com>
 <CAJKOXPdUW5f6_sz14NMU8LP+QoKStB9omXticMkQX4D866okWw@mail.gmail.com>
 <56F396FB.8030402@rock-chips.com>
Message-ID: <56F39BA8.30104@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.03.2016 16:27, Andy Yan wrote:
>>> +- mode-normal: Normal reboot mode, system reboot with command "reboot".
>>> +- mode-recovery: Android Recovery mode, it is a mode to format the
>>> device or update a new image.
>>> +- mode-bootloader: Android fastboot mode, it's a mode to re-flash
>>> partitions on the Android based device.
>>> +- mode-loader: A bootloader mode, it's a mode used to download image
>>> on Rockchip platform,
>>> +              usually used in development.
>> The "bootloader" and "loader" examples are very confusing. Maybe just
>> name the first one as "mode-fastboot" and second as
>> "rockchip-download"? The term "loader" does not look for me as
>> anything related to uploading/downloading new firmware.
> 
>     About these two modes, we have a long discussion with Rob and John [0]
>     We keep them as what you see now to keep compatibility with exiting
> devices.
> 
>  [0] https://lkml.org/lkml/2016/2/2/128

To me these names are non-obvious and I would rather expect choosing
meaningful names when putting something into the mainline. The user
(Android) will use this mainline kernel release in a year or more (3
years for vendors?), so it will have plenty of time to adopt. :)

But this was already discussed and you got ack from Rob, so let's move
on. I don't mind.

Best regards,
Krzysztof
