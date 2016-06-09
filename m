From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Jun 2016 11:44:44 +0100
Subject: [alsa-devel] [PATCH v2 2/9] ASoC: mediatek: implement mediatek
 common structure
In-Reply-To: <1465351572.4197.17.camel@mtksdaap41>
References: <1464929784-5489-1-git-send-email-garlic.tseng@mediatek.com>
 <1464929784-5489-3-git-send-email-garlic.tseng@mediatek.com>
 <20160607155427.GB7510@sirena.org.uk>
 <1465351572.4197.17.camel@mtksdaap41>
Message-ID: <20160609104444.GV7510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 10:06:12AM +0800, Garlic Tseng wrote:
> On Tue, 2016-06-07 at 16:54 +0100, Mark Brown wrote:

> > Do you need to export the individual ops rather than just the ops
> > structure?

> Yes, in 2701 driver we modify some ops.

OK.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160609/6f3c920d/attachment.sig>
