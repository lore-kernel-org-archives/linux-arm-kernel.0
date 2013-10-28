From: sre@debian.org (Sebastian Reichel)
Date: Mon, 28 Oct 2013 18:53:42 +0100
Subject: [RFC 3/4] ASoC: Allow Aux Codecs to be specified using DT
In-Reply-To: <20131028163721.GJ13643@sirena.org.uk>
References: <1382909086-10493-1-git-send-email-sre@debian.org>
 <1382909086-10493-4-git-send-email-sre@debian.org>
 <20131028163721.GJ13643@sirena.org.uk>
Message-ID: <20131028175341.GA28136@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 09:37:21AM -0700, Mark Brown wrote:
> On Sun, Oct 27, 2013 at 10:24:45PM +0100, Sebastian Reichel wrote:
> > This patch adds support for specifying auxiliary codecs and
> > codec configuration via device tree phandles.
> 
> This doesn't apply against current git, please check and resend.

Can you give me a git url to rebase against? I used current git
master from torvalds.

> Please also consider your CC list more carefully, there's an awful lot
> of people on this...

I added exactly those recipients, that were returned by
./scripts/get_maintainer.pl for the patchset.

The list of involved people is quite long, because the patchset
touches devicetree, documentation, boardcode, asoc and the specific
driver.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131028/a0e96a24/attachment.sig>
