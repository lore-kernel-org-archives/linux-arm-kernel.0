From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 15 Jul 2015 13:53:48 +0200
Subject: [PATCH v4 0/2] USB OTG PHY driver for NXP LPC18xx family
In-Reply-To: <55A63AE1.50701@ti.com>
References: <1436474906-2669-1-git-send-email-manabian@gmail.com>
 <55A63AE1.50701@ti.com>
Message-ID: <CAGhQ9Vz+sgVra=fpRa5tNL_kz8oJm+eOY7FETz=pY2-Esv0wAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 July 2015 at 12:50, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
>
> On Friday 10 July 2015 02:18 AM, Joachim Eastwood wrote:
>> This patch set adds support for the internal USB OTG PHY found
>> on NXP LPC18xx and LPC43xx devices. Driver takes care of
>> enabling the PHY and setting the clock rate which is need for
>> USB0 support on this platform.
>>
>> This version address moves the dt node under the creg syscon
>> and rebases the patch set on 4.2-rc1.
>
> merged this to linux-phy tree.

Thanks, Kishon.

regards,
Joachim Eastwood
