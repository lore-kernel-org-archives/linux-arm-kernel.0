From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 20 May 2016 15:03:10 +0200
Subject: [PATCH] reset: oxnas: Use devm register API and get rid of
 platform remove
In-Reply-To: <1463749343.4322.38.camel@pengutronix.de>
References: <1463746897-24813-1-git-send-email-narmstrong@baylibre.com>
 <1463749343.4322.38.camel@pengutronix.de>
Message-ID: <573F0B0E.4090102@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2016 03:02 PM, Philipp Zabel wrote:
> Hi Neil,
> 
> Am Freitag, den 20.05.2016, 14:21 +0200 schrieb Neil Armstrong:
>> Use the brand new devm_reset_controller_register() API to get rid of
>> the platform driver remove callback.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/reset/reset-oxnas.c | 12 +-----------
>>  1 file changed, 1 insertion(+), 11 deletions(-)
>>
>> Hi Philip,
>>
>> This patch is based on your reset/next tree after the new
>> devm_reset_controller_register() was merged.
> 
> Applied, thank you.
> 
>> I hope it could be merged for 4.7.
> 
> I'll submit the branch for 4.8 after 4.7-rc1 is released.
> 
> regards
> Philipp
> 

Thanks Philipp,

Sorry I missed the 4.6 release...

Neil
