From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Mar 2015 10:23:46 -0700
Subject: [PATCH v2 1/7] eeprom: Add a simple EEPROM framework for eeprom
 providers
In-Reply-To: <55112BD6.2070600@linaro.org>
References: <1426240157-2383-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1426240214-2434-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150323210918.GS14954@sirena.org.uk>
 <55108E2B.7050305@linaro.org> <55112BD6.2070600@linaro.org>
Message-ID: <20150324172346.GW17265@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 09:18:14AM +0000, Srinivas Kandagatla wrote:

> I did try your suggestion, by which I could remove the regmap from config.
> One thing I did not like was eeprom-core getting size/stride info directly
> from providers and regmap from regmap apis. I was wondering if we could take
> a step further and introduce new regmap helpers like

> regmap_get_size(regmap)

This is already there.

> regmap_get_stride(regmap)

> Which would be give eeprom-core the size and stride info, doing this way
> would cut down regmap related things from eeprom_config structure to minimal
> and also the source of information would come from just regmap apis.

Documentation/SubmittingPatches...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150324/f8d3ffff/attachment.sig>
