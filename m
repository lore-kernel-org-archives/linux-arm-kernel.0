From: cooloney@gmail.com (Bryan Wu)
Date: Tue, 11 Jun 2013 11:29:31 -0700
Subject: [PATCH v4 1/3] leds: leds-mc13783: Prepare driver to support
 MC13892 LEDs
In-Reply-To: <51B6DBE8.5090505@epfl.ch>
References: <1370883572-877-1-git-send-email-shc_work@mail.ru>
 <51B6DBE8.5090505@epfl.ch>
Message-ID: <CAK5ve-+aQNrVbbOkyHXaB6paDe96wMcZ-7yG=J0Wp9mtH0HGyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 1:12 AM, Philippe R?tornaz
<philippe.retornaz@epfl.ch> wrote:
> Le 10/06/2013 18:59, Alexander Shiyan a ?crit :
>
>> This patch rewrite driver code to be ready to add support for
>> MC13892 LEDs and probe from devicetree.
>>
>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>
>
>
> The whole serie:
>
> Tested-by: Philippe Retornaz <philippe.retornaz@epfl.ch>
>
> On mx31moboard with an mc13783.
>

Thanks for testing, did you test device tree as well? I failed to see
any DTS file adding/change in this patchset.

-Bryan
