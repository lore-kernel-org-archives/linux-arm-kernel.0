From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 Apr 2014 18:12:52 +0100
Subject: [PATCH v4 7/9] ARM: sun7i/sun4i: dt: Add AXP209 support to
 various boards
In-Reply-To: <20140424165847.GC25663@opensource.wolfsonmicro.com>
References: <1397209093-10077-8-git-send-email-carlo@caione.org>
 <20140411122901.GE28800@sirena.org.uk>
 <CAOQ7t2Y2B7f+eZApDHKiKm9=bOXo6oUA2RLY7ENn7qPLQEboMA@mail.gmail.com>
 <20140411161813.GF28800@sirena.org.uk>
 <CAOQ7t2YO_MjUZkkoEe1Grft+fVttWoOro85Sru2P3LXbx8Kjbg@mail.gmail.com>
 <20140418151551.GZ12304@sirena.org.uk>
 <20140423202546.GA3890@nuc.fastwebnet.it>
 <20140424133036.GY12304@sirena.org.uk>
 <20140424163523.GB25663@opensource.wolfsonmicro.com>
 <20140424165847.GC25663@opensource.wolfsonmicro.com>
Message-ID: <20140424171252.GD12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 05:58:47PM +0100, Charles Keepax wrote:

> Ah ok seems I am getting an error but for some reason for me it
> shows up looking very unrelated to the supply mapping. In that it
> shows up much later in the log and doesn't seem to mention the
> MFD at all:

If you look at the warning you'll see that it's complaining that it's
trying to probe a device which has devres stuff attached to it which is
happens at the time the function driver gets loaded.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140424/c7006a8c/attachment.sig>
