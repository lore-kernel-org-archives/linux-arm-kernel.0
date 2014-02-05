From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Wed, 5 Feb 2014 18:18:12 +0200
Subject: [PATCH v5 2/3] clocksource: keystone: add bindings for keystone
 timer
In-Reply-To: <CAL_JsqKVc2fdg1Q+TH6ro9kpJmUYyHw8FCwhORfm2_oj6GYM2Q@mail.gmail.com>
References: <1391608060-10760-1-git-send-email-ivan.khoronzhuk@ti.com>	<1391608060-10760-3-git-send-email-ivan.khoronzhuk@ti.com>
 <CAL_JsqKVc2fdg1Q+TH6ro9kpJmUYyHw8FCwhORfm2_oj6GYM2Q@mail.gmail.com>
Message-ID: <52F26444.5090707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 02/05/2014 04:39 PM, Rob Herring wrote:
> On Wed, Feb 5, 2014 at 7:47 AM, Ivan Khoronzhuk <ivan.khoronzhuk@ti.com> wrote:
>> This patch provides bindings for the 64-bit timer in the KeyStone
>> architecture devices. The timer can be configured as a general-purpose 64-bit
>> timer, dual general-purpose 32-bit timers. When configured as dual 32-bit
>> timers, each half can operate in conjunction (chain mode) or independently
>> (unchained mode) of each other.
> This is software configurable or h/w design time configurations?
>
> Rob
>

This is h/w design time configurations

-- 
Regards,
Ivan Khoronzhuk
