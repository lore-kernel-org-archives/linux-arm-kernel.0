From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 20 Feb 2015 10:24:05 +0000
Subject: [RFC PATCH 1/3] eeprom: Add a simple EEPROM framework
In-Reply-To: <54E6ECEA.7020604@linaro.org>
References: <1424365639-26634-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424365708-26681-1-git-send-email-srinivas.kandagatla@linaro.org>
 <54E69DB0.60701@codeaurora.org> <54E6ECEA.7020604@linaro.org>
Message-ID: <54E70B45.3010203@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/02/15 08:14, Srinivas Kandagatla wrote:
>>
>> Doesn't this need some sort of select REGMAP somewhere?
> May be depends REGMAP would be good.
You are right, just realized that
it should be "select REGMAP"

and for QFPROM it should be "select REGMAP_MMIO"

--srini
