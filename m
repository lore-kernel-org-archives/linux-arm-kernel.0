From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 13 Jul 2012 07:41:11 +0900
Subject: [PATCH] ARM: samsung: adc: fix race in s3c_adc_start
In-Reply-To: <20120712123125.GJ18513@trinity.fluff.org>
References: <1342059131-31251-1-git-send-email-toddpoynor@google.com>
 <20120712123125.GJ18513@trinity.fluff.org>
Message-ID: <4FFF5287.8000608@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/12 21:31, Ben Dooks wrote:
> On Wed, Jul 11, 2012 at 07:12:11PM -0700, Todd Poynor wrote:
>> Checking for adc->ts_pend already claimed should be done with the
>> lock held.
>>
>> Change-Id: Ic9f15e26bd19934ab8c2885ce5df265933ac304a
>> Signed-off-by: Todd Poynor<toddpoynor@google.com>
> Acked-by: Ben Dooks<ben-linux@fluff.org>

Ben, thanks for your ack, will apply.

BTW, Todd, do you want to keep the 'Change-Id' in mainline?
If you don't mind, I'd like to remove it...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
