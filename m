From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 28 Jan 2015 17:35:35 +0100
Subject: [PATCH 1/5] mmc: pwrseq: Document that simple sequence support
 more than one GPIO
In-Reply-To: <54C90F89.1040500@linaro.org>
References: <1422439819-29854-1-git-send-email-javier.martinez@collabora.co.uk>
 <1422439819-29854-2-git-send-email-javier.martinez@collabora.co.uk>
 <54C90F89.1040500@linaro.org>
Message-ID: <54C90FD7.40601@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Srinivas,

On 01/28/2015 05:34 PM, Srinivas Kandagatla wrote:
>> -- reset-gpios : contains a GPIO specifier. The reset GPIO is asserted at
>> -	initialization and prior we start the power up procedure of the card. It
>> -	will be de-asserted right after the power has been provided to the card.
>> +- reset-gpios : contains a list of GPIO specifiers. The reset GPIOs are asserted
>> +	at initialization and prior we start the power up procedure of the card.
>> +	Will be de-asserted right after the power has been provided to the card.
> Makes sense if you add "They" before last sentence.

Thanks, I'll change it.

Best regards,
Javier
