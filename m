From: broonie@kernel.org (Mark Brown)
Date: Mon, 28 Oct 2013 12:49:36 -0700
Subject: [RFC 3/4] ASoC: Allow Aux Codecs to be specified using DT
In-Reply-To: <20131028175341.GA28136@earth.universe>
References: <1382909086-10493-1-git-send-email-sre@debian.org>
 <1382909086-10493-4-git-send-email-sre@debian.org>
 <20131028163721.GJ13643@sirena.org.uk>
 <20131028175341.GA28136@earth.universe>
Message-ID: <20131028194936.GC18208@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 06:53:42PM +0100, Sebastian Reichel wrote:
> On Mon, Oct 28, 2013 at 09:37:21AM -0700, Mark Brown wrote:

> > This doesn't apply against current git, please check and resend.

> Can you give me a git url to rebase against? I used current git
> master from torvalds.

>From MAINTAINERS:

SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEMENT (ASoC)
M:      Liam Girdwood <lgirdwood@gmail.com>
M:      Mark Brown <broonie@kernel.org>
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
L:      alsa-devel at alsa-project.org (moderated for non-subscribers)
W:      http://alsa-project.org/main/index.php/ASoC
S:      Supported
F:      Documentation/sound/alsa/soc/
F:      sound/soc/
F:      include/sound/soc*

> > Please also consider your CC list more carefully, there's an awful lot
> > of people on this...

> I added exactly those recipients, that were returned by
> ./scripts/get_maintainer.pl for the patchset.

> The list of involved people is quite long, because the patchset
> touches devicetree, documentation, boardcode, asoc and the specific
> driver.

You shouldn't be using the output of get_maintainers directly, you
should understand why everyone it's including is in the list and if they
really should be.  This is especially important if you are sending a
series that covers many subsystems, or nested subsystems.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131028/78280c9a/attachment.sig>
