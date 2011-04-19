From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Apr 2011 10:30:57 +0100
Subject: [RFC 0/4] convert stmp into mxs and delete the obsolete platform
In-Reply-To: <1303093838-23959-1-git-send-email-w.sang@pengutronix.de>
References: <1303093838-23959-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20110419093057.GE22799@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 04:30:34AM +0200, Wolfram Sang wrote:
> I tried a smaller scaled cleanup before, but now that there are talks
> about ARM consolidation everywhere, I'll be more brave :)

This looks really good.  Once there's concensus on this, I'd like to pull
it into a local consolidation branch so that we have one central place
where we can gauge our progress.

Only issue is to do with wrapping - please wrap at or before column 72.
Two reasons - when folk reply to your messages, they don't wrap as a
result of the '> ' prefix.  Secondly, for git commits it allows a tab
to be inserted before the description without the possibility of losing
words off the right side of the screen (see the git log output).

Thanks.
