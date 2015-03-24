From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 24 Mar 2015 19:26:45 +0000
Subject: [PATCH v2 1/7] eeprom: Add a simple EEPROM framework for eeprom
 providers
In-Reply-To: <20150324190226.GB17265@sirena.org.uk>
References: <1426240157-2383-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1426240214-2434-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150323210918.GS14954@sirena.org.uk> <55108E2B.7050305@linaro.org>
 <55112BD6.2070600@linaro.org> <20150324172346.GW17265@sirena.org.uk>
 <5511AE38.3000108@linaro.org> <20150324190226.GB17265@sirena.org.uk>
Message-ID: <5511BA75.3020305@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/03/15 19:02, Mark Brown wrote:
> On Tue, Mar 24, 2015 at 06:34:32PM +0000, Srinivas Kandagatla wrote:
>> >On 24/03/15 17:23, Mark Brown wrote:
>>>> > >>regmap_get_size(regmap)
>>> > >This is already there.
>> >Sorry, I can't see any such api atleast in v4.0-rc5 and linux-next? Are you
>> >referring to another api which does the same job?
> regmap_get_val_bytes()
>
This would return value bytes, but I wanted is the regmap->max_register 
value which would be used for sanity checks in eeprom-core.

--srini
