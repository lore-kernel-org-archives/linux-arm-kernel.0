From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 4 Apr 2016 08:42:48 +0200
Subject: [PATCH 1/7] ARM: dts: armv7-m: add unit name to
 interrupt-controller
In-Reply-To: <20160404060558.GY6191@pengutronix.de>
References: <1459290646-3592-1-git-send-email-manabian@gmail.com>
 <1459290646-3592-2-git-send-email-manabian@gmail.com>
 <20160404060558.GY6191@pengutronix.de>
Message-ID: <CAGhQ9Vxyf1m6mCpFZdfFymA-_PO9KsGuvPaBBrPxxbSEHT9eUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2016 at 08:05, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello Joachim,
>
> On Wed, Mar 30, 2016 at 12:30:40AM +0200, Joachim Eastwood wrote:
>> Add unit name to nvic to remove the following warning:
>>  Warning (unit_address_vs_reg): Node /nv-interrupt-controller has a reg
>>                               or ranges property, but no unit name
>>
>> Also correct the node name to 'interrupt-controller' while changing the
>> line.
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> Looks right,
>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks, Uwe.


Unless any of the other Cortex-M platform maintainers (added more CCs)
has any objections I'll take this through the lpc18xx tree. I will
send a pull request to arm-soc with this soon.


regards,
Joachim Eastwood
