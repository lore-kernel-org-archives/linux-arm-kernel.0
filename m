From: carlo@caione.org (Carlo Caione)
Date: Wed, 25 Nov 2015 10:25:45 +0100
Subject: [PATCH v3 1/4] watchdog: meson: Enable meson SoC specific data
In-Reply-To: <20151124181911.GA12289@roeck-us.net>
References: <1446985137-25498-1-git-send-email-carlo@caione.org>
 <1446985137-25498-2-git-send-email-carlo@caione.org>
 <5640B5BF.9040909@roeck-us.net>
 <CAOQ7t2bmNNTPxgZy4uZQF_u4yH2nxfMR_FqpKM0GavoUS9rRkA@mail.gmail.com>
 <20151124181911.GA12289@roeck-us.net>
Message-ID: <CAOQ7t2ZY8BMMSN5F-9GewZSfUewa-0jA5tufe9NCkLZObjrdWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 7:19 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Nov 11, 2015 at 09:54:04AM +0100, Carlo Caione wrote:
>> On Mon, Nov 9, 2015 at 4:03 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> > On 11/08/2015 04:18 AM, Carlo Caione wrote:
>> >>
>> >> From: Carlo Caione <carlo@endlessm.com>
>> >>
>> >> With this patch we refactor the driver code to enable watchdog support
>> >> for all platforms based on Amlogic meson SoCs.
>> >> The new default timeout is also now chosen considering the maximum
>> >> timeout allowed by the SoC.
>> >>
>> >> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>> >
>> >
>> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>
>> Wim,
>> any (N)ACK on this?
>>
> Carlo,
>
> Unless I missed it, we still don't have an Ack from a devicetree
> maintainer for the devicetree changes.

I'm the maintainer for the Meson platform and since the changes are
trivial I'm going to merge them after the driver is taken in the
watchdog tree.

Cheers,

-- 
Carlo Caione
