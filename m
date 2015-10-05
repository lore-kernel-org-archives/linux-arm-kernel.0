From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 05 Oct 2015 09:59:02 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Add missing QCOM APQ8064 configs
In-Reply-To: <7133797.1AP9OuVQ6T@wuerfel>
References: <1443704258-3180-1-git-send-email-srinivas.kandagatla@linaro.org>
 <7133797.1AP9OuVQ6T@wuerfel>
Message-ID: <56123BD6.7060403@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/10/15 09:14, Arnd Bergmann wrote:
> On Thursday 01 October 2015 13:57:38 Srinivas Kandagatla wrote:
>> This patch adds few missing essential configs in the multi_v7_defconf,
>> absense of some configs like PINCTRL_APQ8064 would prevent the board from
>> getting access to serial.
>>
>> cc: Kevin Hilman <khilman@kernel.org>
>> cc: Tyler Baker <tyler.baker@linaro.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> Can you make some of these '=m' instead of '=y'? We try to have most things
> that are not essential for booting as loadable modules, so the kernel
> doesn't get too big.
Yes, I can make the USB and SATA as modules and other options are very 
essential to get the board booting with console.

Will send a new version.

--srini
>
> 	Arnd
>
