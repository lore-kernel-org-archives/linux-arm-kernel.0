From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Mar 2015 12:02:26 -0700
Subject: [PATCH v2 1/7] eeprom: Add a simple EEPROM framework for eeprom
 providers
In-Reply-To: <5511AE38.3000108@linaro.org>
References: <1426240157-2383-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1426240214-2434-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150323210918.GS14954@sirena.org.uk>
 <55108E2B.7050305@linaro.org> <55112BD6.2070600@linaro.org>
 <20150324172346.GW17265@sirena.org.uk>
 <5511AE38.3000108@linaro.org>
Message-ID: <20150324190226.GB17265@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 06:34:32PM +0000, Srinivas Kandagatla wrote:
> On 24/03/15 17:23, Mark Brown wrote:

> >>regmap_get_size(regmap)

> >This is already there.

> Sorry, I can't see any such api atleast in v4.0-rc5 and linux-next? Are you
> referring to another api which does the same job?

regmap_get_val_bytes()

> >>Which would be give eeprom-core the size and stride info, doing this way
> >>would cut down regmap related things from eeprom_config structure to minimal
> >>and also the source of information would come from just regmap apis.

> >Documentation/SubmittingPatches...

> Am not sure what you meant here, Am guessing that you asked me to keep the
> respective maintainers in the loop and follow the guide, when I resend the
> patch?

I'm saying that you should send patches if you want to add features.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150324/bc937ec6/attachment.sig>
