From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 18 Jun 2017 22:50:42 +0200
Subject: [PATCH v4 05/28] clocksource: owl: Add S900 support
In-Reply-To: <20170606163453.GE2345@mai>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-6-afaerber@suse.de> <20170606163453.GE2345@mai>
Message-ID: <dbd8600a-d04a-d679-1c59-81a00602ea77@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.06.2017 um 18:34 schrieb Daniel Lezcano:
> On Tue, Jun 06, 2017 at 02:54:03AM +0200, Andreas F?rber wrote:
>> The Actions Semi S900 SoC provides four 32-bit timers, TIMER0/1/2/3,
>> but no 2Hz timers.
>>
>> An S900 datasheet can be found in 96Boards documentation:
>> https://github.com/96boards/documentation/blob/master/ConsumerEdition/Bubblegum-96/HardwareDocs/SoC_bubblegum96.pdf
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks, applied to linux-actions.git v4.13/soc branch:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.13/soc

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
