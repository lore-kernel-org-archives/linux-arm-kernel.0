From: broonie@kernel.org (Mark Brown)
Date: Tue, 5 May 2015 23:35:42 +0100
Subject: [PATCH RFC v2 10/13] sound/core: add DRM ELD helper
In-Reply-To: <s5ha8ymy3e2.wl-tiwai@suse.de>
References: <20150402092050.GH24899@n2100.arm.linux.org.uk>
 <E1YdbKA-00085Q-LL@rmk-PC.arm.linux.org.uk>
 <s5ha8ymy3e2.wl-tiwai@suse.de>
Message-ID: <20150505223542.GM15510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 05, 2015 at 05:57:09PM +0200, Takashi Iwai wrote:
> At Thu, 02 Apr 2015 10:22:06 +0100,
> Russell King wrote:

> > +config SND_PCM_ELD
> > +	bool

> I don't mind much adding this one, but a new Kconfig is always a
> question.  I'd like to hear other's opinion, too.

One point in favour of this is that there's been some discussion
recently of IoT applications with very low resource requirements that
might need audion functionality so it's likely that people will be
taking a look at trying to minimize code size for the audio stack.  This
sort of configurability may well be useful for such applications.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150505/d456c52b/attachment.sig>
