From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 18 Jun 2017 22:43:51 +0200
Subject: [PATCH v4 04/28] clocksource: Add Owl timer
In-Reply-To: <20170606163355.GD2345@mai>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-5-afaerber@suse.de> <20170606163355.GD2345@mai>
Message-ID: <b2af603d-0a7c-1bcd-c661-9a20ce63994c@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.06.2017 um 18:33 schrieb Daniel Lezcano:
> On Tue, Jun 06, 2017 at 02:54:02AM +0200, Andreas F?rber wrote:
>> The Actions Semi S500 SoC provides four timers, 2Hz0/1 and 32-bit TIMER0/1.
>>
>> Use TIMER0 as clocksource and TIMER1 as clockevents.
>>
>> Based on LeMaker linux-actions tree.
>>
>> An S500 datasheet can be found on the LeMaker Guitar pages:
>> http://www.lemaker.org/product-guitar-download-29.html
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks. It seems this is not going through a central clocksource tree,
so I'm applying it to a new linux-actions.git v4.13/soc branch:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.13/soc

Let me know if you intend to take it through some other tree instead.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
