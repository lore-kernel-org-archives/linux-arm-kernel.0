From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Jun 2016 11:44:24 +0100
Subject: [alsa-devel] [PATCH v2 6/9] ASoC: mediatek: add mt2701 platform
 driver implementation.
In-Reply-To: <1465356742.18601.7.camel@mtksdaap41>
References: <1464929784-5489-1-git-send-email-garlic.tseng@mediatek.com>
 <1464929784-5489-7-git-send-email-garlic.tseng@mediatek.com>
 <20160607163112.GD7510@sirena.org.uk>
 <1465356742.18601.7.camel@mtksdaap41>
Message-ID: <20160609104424.GU7510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 11:32:22AM +0800, Garlic Tseng wrote:
> On Tue, 2016-06-07 at 17:31 +0100, Mark Brown wrote:

> > > +	SOC_DAPM_SINGLE_AUTODISABLE("Multi ch asrc out3", PWR2_TOP_CON, 7, 1,
> > > +				    1),
> > > +};

> > On/off controls should end in Switch.

> Do you means that the name should end in Switch? Something like "Multi
> ch asrc out3 Switch" (or maybe a shorter one)

Yes, exactly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160609/7b7f7530/attachment-0001.sig>
