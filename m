From: eric@eukrea.com (=?UTF-8?B?RXJpYyBCw6luYXJk?=)
Date: Thu, 29 Jul 2010 15:33:12 +0200
Subject: [PATCH v3] video/imxfb.c: allow usage without
	BACKLIGHT_CLASS_DEVICE
In-Reply-To: <4C5180E9.8070203@ru.mvista.com>
References: <20100729124534.GB6268@pengutronix.de>
	<1280408618-21364-1-git-send-email-eric@eukrea.com>
	<4C5180E9.8070203@ru.mvista.com>
Message-ID: <4C518318.70909@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 29/07/2010 15:23, Sergei Shtylyov a ?crit :
>> +#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || \
>> + (defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE) && \
>> + defined(CONFIG_FB_IMX__MODULE))
>
> Are you sure there should be two underscores before MODULE?
>
no ... that was only compile tested as you can see :-(
Thanks and sorry for the noise for such a stupid patch !

Eric
