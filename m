From: stefan@agner.ch (Stefan Agner)
Date: Sun, 03 Apr 2016 23:51:45 -0700
Subject: [PATCH 1/7] ARM: dts: armv7-m: add unit name to
 interrupt-controller
In-Reply-To: <CAGhQ9Vxyf1m6mCpFZdfFymA-_PO9KsGuvPaBBrPxxbSEHT9eUA@mail.gmail.com>
References: <1459290646-3592-1-git-send-email-manabian@gmail.com>
 <1459290646-3592-2-git-send-email-manabian@gmail.com>
 <20160404060558.GY6191@pengutronix.de>
 <CAGhQ9Vxyf1m6mCpFZdfFymA-_PO9KsGuvPaBBrPxxbSEHT9eUA@mail.gmail.com>
Message-ID: <ff9b34a6b4aa15fa7b98916c41245084@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-04-03 23:42, Joachim  Eastwood wrote:
> On 4 April 2016 at 08:05, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
>> Hello Joachim,
>>
>> On Wed, Mar 30, 2016 at 12:30:40AM +0200, Joachim Eastwood wrote:
>>> Add unit name to nvic to remove the following warning:
>>>  Warning (unit_address_vs_reg): Node /nv-interrupt-controller has a reg
>>>                               or ranges property, but no unit name
>>>
>>> Also correct the node name to 'interrupt-controller' while changing the
>>> line.
>>>
>>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> Looks right,
>>
>> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Thanks, Uwe.
> 
> 
> Unless any of the other Cortex-M platform maintainers (added more CCs)
> has any objections I'll take this through the lpc18xx tree. I will
> send a pull request to arm-soc with this soon.

Your patch looks right, I agree we should merge yours.

Acked-by: Stefan Agner <stefan@agner.ch>

--
Stefan
