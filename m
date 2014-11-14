From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 14 Nov 2014 10:35:56 +0100
Subject: [alsa-devel] [PATCH v3] of: replace Asahi Kasei Corp venter prefix
In-Reply-To: <87k32yd0bd.wl%kuninori.morimoto.gx@renesas.com>
References: <878ulzx6hr.wl%kuninori.morimoto.gx@gmail.com>
 <20140922130026.GK3290@leverpostej>
 <CAMuHMdX22z97SbGS1HDiYfJ1PXxyEN2S8D7w4sr+4bUwD+mJZw@mail.gmail.com>
 <20140922132743.GM3290@leverpostej>
 <87y4rfhmgl.wl%kuninori.morimoto.gx@renesas.com>
 <1415845309.4269.6.camel@perches.com>
 <20141113025105.GA16652@verge.net.au>
 <87vbmjhj00.wl%kuninori.morimoto.gx@renesas.com>
 <20141113110740.GE3815@sirena.org.uk>
 <87k32yd0bd.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20141114093554.GC3810@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 01:43:03AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current vendor-prefixes.txt already has
> "ak" prefix for Asahi Kasei Corp by
> ae8c4209af2cec065fef15d200a42a04130799f7

It's usually enough to show the first 12 (or so) characters of the SHA1
here. git will show you the right one if you do something like:

	git log --abbrev=12 --abbrev-commit

It's probably useful to "git config core.abbrev 12" for Linux kernel
repositories.

Other than that it seems like you're being overly careful about not
exceeding 72 characters. Your lines seem to wrap at around less than
50 columns. However, making lines too short results in equally hard to
read commit messages, so please try to shoot for 72 columns for maximum
readability.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141114/b6f807cf/attachment.sig>
