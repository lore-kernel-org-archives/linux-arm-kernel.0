From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 Oct 2014 10:31:40 +0000
Subject: [PATCH v5 3/4] regulator: max77686: Add suspend disable for some
 LDOs
In-Reply-To: <1414577934.18868.7.camel@AMDC1943>
References: <1414411911-5539-1-git-send-email-k.kozlowski@samsung.com>
 <1414411911-5539-4-git-send-email-k.kozlowski@samsung.com>
 <20141028223121.GH18557@sirena.org.uk>
 <1414574413.18868.6.camel@AMDC1943>
 <20141029100142.GR18557@sirena.org.uk>
 <1414577934.18868.7.camel@AMDC1943>
Message-ID: <20141029103140.GY18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 11:18:54AM +0100, Krzysztof Kozlowski wrote:
> On ?ro, 2014-10-29 at 10:01 +0000, Mark Brown wrote:

> > No, this isn't suspend enable control - this is normal, standard enable
> > control and the device has no suspend enable control.

> You mean that for such regulator the driver shouldn't implement
> suspend_enable()?

Yes, if there is no separate control of suspend mode in hardware then of
course the driver shouldn't implement operations for things it doesn't
have.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141029/4adfbd3e/attachment.sig>
