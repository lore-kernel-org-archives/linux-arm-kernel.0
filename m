From: philippe.retornaz@epfl.ch (=?ISO-8859-1?Q?Philippe_R=E9tornaz?=)
Date: Wed, 12 Jun 2013 08:41:37 +0200
Subject: [PATCH v4 1/3] leds: leds-mc13783: Prepare driver to support
 MC13892 LEDs
In-Reply-To: <CAK5ve-+aQNrVbbOkyHXaB6paDe96wMcZ-7yG=J0Wp9mtH0HGyw@mail.gmail.com>
References: <1370883572-877-1-git-send-email-shc_work@mail.ru>
 <51B6DBE8.5090505@epfl.ch>
 <CAK5ve-+aQNrVbbOkyHXaB6paDe96wMcZ-7yG=J0Wp9mtH0HGyw@mail.gmail.com>
Message-ID: <51B81821.7020507@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 11/06/2013 20:29, Bryan Wu a ?crit :
> On Tue, Jun 11, 2013 at 1:12 AM, Philippe R?tornaz
> <philippe.retornaz@epfl.ch> wrote:
>> Le 10/06/2013 18:59, Alexander Shiyan a ?crit :
>>
>>> This patch rewrite driver code to be ready to add support for
>>> MC13892 LEDs and probe from devicetree.
>>>
>>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>>
>>
>>
>> The whole serie:
>>
>> Tested-by: Philippe Retornaz <philippe.retornaz@epfl.ch>
>>
>> On mx31moboard with an mc13783.
>>
>
> Thanks for testing, did you test device tree as well? I failed to see
> any DTS file adding/change in this patchset.
>

No, I tested on a mx31moboard: mc13783 with an imx31, so no device tree.
But AFAIK this board was the only in-tree user of this driver.

Regards,

Philippe
