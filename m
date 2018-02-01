From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 01 Feb 2018 14:36:58 -0800
Subject: [PATCH v3 0/5] ARM64: dts: meson-axg: UART DT updates
In-Reply-To: <8990554d-e995-e432-8f50-3b247f71b0fd@amlogic.com> (Yixun Lan's
 message of "Wed, 31 Jan 2018 10:25:45 +0800")
References: <20180111023401.125658-1-yixun.lan@amlogic.com>
 <7hr2q6c2r4.fsf@baylibre.com>
 <CAOi56cW4ufsegpy7heK1+pCxvZ2gz5Lf3dkUgxkZCgMq5oBzSA@mail.gmail.com>
 <8990554d-e995-e432-8f50-3b247f71b0fd@amlogic.com>
Message-ID: <7hinbg8hh1.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yixun,

Yixun Lan <yixun.lan@amlogic.com> writes:

> On 01/31/18 08:22, Kevin Hilman wrote:
>> On Tue, Jan 30, 2018 at 4:04 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>>> Yixun Lan <yixun.lan@amlogic.com> writes:
>>>
>>>> HI Kevin
>>>>  These are the UART DT updates for the Meson-AXG platform.
>>>>
>>>>  The patch 1 is a general fix.
>>>> Other patches are about adding clock & pinctrl info, then using them.
>>>> Last patch enable UART_A which connect to a BT module on the S400 board.
>>>
>>> Applied to v4.16/dt64,
>> 
>> Oops, I meant v4.17.
>> 
>
> Hi Kevin
>  I should warn you about the patch 3 [1], it actually depend on the gpio
> renaming patch [2]
>
>  I'm still waiting Linus to take patch [2], then update according
> (or you could help amend the patch? it's simply a
> 's/uart_ao_b_gpioz/uart_ao_b_z/g)

I've made that change in the version of the patch that I applied to the
v4.17/dt64 branch.

It's harmless without the pinctrl patch applied anyways.

Kevin
