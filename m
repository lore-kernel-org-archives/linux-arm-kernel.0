From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Fri, 26 Aug 2011 14:47:39 +0200
Subject: [patch 1/1] efika: Configure esdhc cd/wp on efika mx/sb
In-Reply-To: <20110825150214.GZ31404@pengutronix.de> (Sascha Hauer's message
	of "Thu, 25 Aug 2011 17:02:14 +0200")
References: <20110825143806.625158261@rtp-net.org>
	<20110825150214.GZ31404@pengutronix.de>
Message-ID: <878vqg9w5w.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> Hi Arnaud,

Hi,
>
> On Thu, Aug 25, 2011 at 04:37:57PM +0200, Arnaud Patard wrote:
>> Update sdhc support on efika to make use of the latest mmc fixes.
>> 
>> 
>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>> @@ -451,7 +465,8 @@ static void __init efikasb_board_init(vo
>>  
>>  	mx51_efikasb_board_id();
>>  	mx51_efikasb_usb();
>> -	imx51_add_sdhci_esdhc_imx(1, NULL);
>> +	imx51_add_sdhci_esdhc_imx(0, &sd0_pdata);
>> +	imx51_add_sdhci_esdhc_imx(1, &sd1_pdata);
>>  	mx51_efikasb_display();
>         ^^^^^^^^^^^^^^^^^^^
>
> Looks good, but please rebase this onto a mainline kernel.

oops, sorry. You'll receive a new version very soon.

Arnaud
