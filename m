From: broonie@kernel.org (Mark Brown)
Date: Fri, 31 Oct 2014 11:54:11 +0000
Subject: [PATCH 6/8] regulator: max77686: Add external GPIO control
In-Reply-To: <1414755947.7318.3.camel@AMDC1943>
References: <1414486356.24949.19.camel@AMDC1943>
 <1414498308.24949.32.camel@AMDC1943>
 <1414579362.18868.11.camel@AMDC1943>
 <5450C63B.3000602@collabora.co.uk>
 <CAAVeFuLncbkNLGxEAj90yMmugRDNjtjeGoV_QYTMDZ7NVMJCmg@mail.gmail.com>
 <1414681386.26703.6.camel@AMDC1943>
 <CAAVeFuJo1wTyxOo4FEZM3=GTejuSHi+mnr=QV6HUeV5mAOCmqg@mail.gmail.com>
 <1414741898.20071.8.camel@AMDC1943>
 <20141031103217.GJ18557@sirena.org.uk>
 <1414755947.7318.3.camel@AMDC1943>
Message-ID: <20141031115411.GO18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 12:45:47PM +0100, Krzysztof Kozlowski wrote:

> Then I'll add it.

> Mark, what device should be assigned to "config.dev" during registration
> of regulators? The regulator driver's device or its parent (MFD main
> driver)?

> Various drivers do this differently.

Normally the parent device.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141031/70a68966/attachment.sig>
