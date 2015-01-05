From: Ying.Liu@freescale.com (Liu Ying)
Date: Mon, 5 Jan 2015 18:05:06 +0800
Subject: [PATCH RFC v7 16/21] drm: panel: Add support for Himax HX8369A
 MIPI DSI panel
In-Reply-To: <20150105085424.GP2711@phenom.ffwll.local>
References: <1419910451-15268-1-git-send-email-Ying.Liu@freescale.com>
 <1419910451-15268-17-git-send-email-Ying.Liu@freescale.com>
 <20150105085424.GP2711@phenom.ffwll.local>
Message-ID: <54AA61D2.1040002@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 01/05/2015 04:54 PM, Daniel Vetter wrote:
> On Tue, Dec 30, 2014 at 11:34:06AM +0800, Liu Ying wrote:
>> This patch adds support for Himax HX8369A MIPI DSI panel.
>>
>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
>> ---
>> v6->v7:
>>   * Address Andrzej Hajda's following comments.
>>   * Simplify the return logic in hx8369a_dcs_write().
>>   * Replace the macro hx8369a_dsi_init_helper() with a function array to improve
>>     the code quality.
>>   * Handle error cases during getting gpios in probe().
>>   * Add 'Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>'.
>
> If you only update one patch in a big series it's imo better to just
> resend that one to avoid spamming the mailing list with noise. Imo it also
> helps to keep the discussion all nicely grouped together.

Thanks for your suggestion.  I would try to make people happy about
the way the series is submitted for review.

>
> In any case please give a short overview of what changed in the cover
> letter when resending the entire series so that people don't have to go
> through all the invidual patches.

Yes, absolutely.  I gave short overviews of what changed in the very
beginning of the cover letters from v2 to v8 and I will do this in
every necessary follow-up version.

Regards,
Liu Ying

> -Daniel
>
