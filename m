From: broonie@kernel.org (Mark Brown)
Date: Mon, 23 Jun 2014 10:47:34 +0100
Subject: [PATCH v2 07/10] regulator: Add driver for Maxim 77802 PMIC
 regulators
In-Reply-To: <53A7F339.7050608@collabora.co.uk>
References: <1402941758-11216-1-git-send-email-javier.martinez@collabora.co.uk>
 <1402941758-11216-8-git-send-email-javier.martinez@collabora.co.uk>
 <20140616192500.GJ5099@sirena.org.uk>
 <53A01D54.10506@collabora.co.uk>
 <20140617141254.GP5099@sirena.org.uk>
 <53A06749.1010606@collabora.co.uk>
 <20140621204026.GH22657@sirena.org.uk>
 <53A7F339.7050608@collabora.co.uk>
Message-ID: <20140623094734.GV24291@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 11:28:25AM +0200, Javier Martinez Canillas wrote:
> On 06/21/2014 10:40 PM, Mark Brown wrote:

> > That's not really relevant here - I'm asking if the regulators get their
> > own supplies rather than if anything uses them.

> Sorry if I keep misunderstanding your question but the regulators in this PMIC
> don't have a parent supply/regulator node.

They should, I'm pretty sure the device does actually regulate one
supply into another.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140623/89fb712b/attachment-0001.sig>
