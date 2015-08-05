From: broonie@kernel.org (Mark Brown)
Date: Wed, 5 Aug 2015 12:59:51 +0100
Subject: [PATCH v2 0/4] Add SPDIF support for rockchip
In-Reply-To: <1438756921.27576.4.camel@collabora.co.uk>
References: <1438687099-14282-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <20150804153649.GP20873@sirena.org.uk>
 <1438756921.27576.4.camel@collabora.co.uk>
Message-ID: <20150805115951.GK20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 08:42:01AM +0200, Sjoerd Simons wrote:
> On Tue, 2015-08-04 at 16:36 +0100, Mark Brown wrote:

> > I only appear to have patch 2 (with the misspelt subject), not the
> > binding documentation.

> Applogies, Send that patch specifically to you now.

And I deleted it unread because it was just some random off list patch
with no context.  :(

> Seems get_maintainers.pl didn't include you in the list (nor the other
> asoc maintainers in the list), I guess it might be good to add
> Documentation/devicetree/bindings/sounds/ to the ASoC file list in
> MAINTAINTERS ?

Please follow the process covered in SubmittingPatches for making kernel
changes, but note that there's generic sound drivers as well as ASoC
ones.

In general it is a very bad idea to rely on get_maintainers, it is prone
to both false positives and missing relevant people.  It can be useful
to look at but you need to think about what it's telling you.  In this
case it should be fairly easy to tell that you ought to send the binding
documentation along with the driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150805/1b4a4ea0/attachment.sig>
