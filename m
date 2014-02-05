From: robherring2@gmail.com (Rob Herring)
Date: Wed, 5 Feb 2014 11:41:34 -0600
Subject: [PATCH v5 2/3] clocksource: keystone: add bindings for keystone
 timer
In-Reply-To: <52F26444.5090707@ti.com>
References: <1391608060-10760-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1391608060-10760-3-git-send-email-ivan.khoronzhuk@ti.com>
 <CAL_JsqKVc2fdg1Q+TH6ro9kpJmUYyHw8FCwhORfm2_oj6GYM2Q@mail.gmail.com>
 <52F26444.5090707@ti.com>
Message-ID: <CAL_JsqL6YDcZJa5xziR7dP-bEt1CO4BtL1vsO8Qm+hFwgCiQ1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 5, 2014 at 10:18 AM, Ivan Khoronzhuk <ivan.khoronzhuk@ti.com> wrote:
>
> On 02/05/2014 04:39 PM, Rob Herring wrote:
>>
>> On Wed, Feb 5, 2014 at 7:47 AM, Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>> wrote:
>>>
>>> This patch provides bindings for the 64-bit timer in the KeyStone
>>> architecture devices. The timer can be configured as a general-purpose
>>> 64-bit
>>> timer, dual general-purpose 32-bit timers. When configured as dual 32-bit
>>> timers, each half can operate in conjunction (chain mode) or
>>> independently
>>> (unchained mode) of each other.
>>
>> This is software configurable or h/w design time configurations?
>>
>> Rob
>>
>
> This is h/w design time configurations

Then it seems like the binding should provide for describing those
differences either with a property or different compatible strings.

Rob
