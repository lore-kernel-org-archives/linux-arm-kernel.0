From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 30 Jun 2015 19:45:15 +0200
Subject: [PATCH] clk: samsung: fix cpu clock's flags checking
In-Reply-To: <7416838.2ZUPGjSqFp@amdc1976>
References: <1435598978-21800-1-git-send-email-b.zolnierkie@samsung.com>
 <5591DD9B.4030507@samsung.com>
 <CABxcv=kVL94rdFgNKcxx2JOi9WRFnvhMWrpjEDcEmx7q7cEsgQ@mail.gmail.com>
 <7416838.2ZUPGjSqFp@amdc1976>
Message-ID: <5592D5AB.2020802@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Bartlomiej,

On 06/30/2015 07:17 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Tuesday, June 30, 2015 08:27:36 AM Javier Martinez Canillas wrote:
>> On Tue, Jun 30, 2015 at 2:06 AM, Krzysztof Kozlowski
>> <k.kozlowski@samsung.com> wrote:
>> > On 30.06.2015 02:29, Bartlomiej Zolnierkiewicz wrote:
>> >> CLK_CPU_HAS_DIV1 and CLK_CPU_NEEDS_DEBUG_ALT_DIV masks were
>> >> incorrectly used as a bit numbers.  Fix it.
>> >>
>> >> Tested on Exynos4210 based Origen board and on Exynos5250 based
>> >> Arndale board.
>> >>
>> >> Cc: Tomasz Figa <tomasz.figa@gmail.com>
>> >> Cc: Michael Turquette <mturquette@baylibre.com>
>> >> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> >> Cc: Thomas Abraham <thomas.ab@samsung.com>
>> >> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> >> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> >> ---
>> >>  drivers/clk/samsung/clk-cpu.c | 10 +++++-----
>> >>  1 file changed, 5 insertions(+), 5 deletions(-)
>> >
>> > Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> >
>> 
>> Looks good to me as well.
>> 
>> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
> Krzysztof has noted that I should use your @dowhile0.org e-mail address
> instead of @collabora.co.uk one, is this right?
>

I don't know what is the policy for tags but Krzysztof is correct that
this email address is going away this week so for future patches please
use my personal @dowhile0.org address instead.

Best regards,
Javier
