From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Oct 2013 18:42:05 +0100
Subject: [PATCH 4/4] sound/soc/atmel: don't use
 devm_pinctrl_get_select_default() in probe
In-Reply-To: <20131017164331.GA2896@katana>
References: <1381681071-6021-1-git-send-email-wsa@the-dreams.de>
 <1381681071-6021-5-git-send-email-wsa@the-dreams.de>
 <20131014131748.GU2443@sirena.org.uk>
 <20131014145629.GA17351@katana>
 <20131014163753.GF2443@sirena.org.uk>
 <20131017164331.GA2896@katana>
Message-ID: <20131017174205.GQ2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 06:46:14PM +0200, Wolfram Sang wrote:

> On the other hand, MAINTAINERS information gets overlooked and/or could
> get stale. Thinking about it again, it is probably less work (at least
> for me with i2c) to create a git-hook fixing the subject line than to
> always nag people.

That doesn't fix the main problem which is getting the mail looked at in
the first place - not having a subject line that people are looking for
makes it easy for things to get dropped on the floor.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131017/5a9483e9/attachment.sig>
