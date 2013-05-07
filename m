From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 May 2013 18:32:31 +0100
Subject: [GIT PULL] ARM: Third batch of arm-soc changes for 3.10
In-Reply-To: <CA+55aFwMXmJ9V+3o62ELm-0NT1DaUCTvidmAhJSXzQcTMfJygA@mail.gmail.com>
References: <1367942534-2934003-1-git-send-email-arnd@arndb.de>
 <CA+55aFwMXmJ9V+3o62ELm-0NT1DaUCTvidmAhJSXzQcTMfJygA@mail.gmail.com>
Message-ID: <20130507173231.GL18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 07, 2013 at 10:02:22AM -0700, Linus Torvalds wrote:
> So you seem to have blasted this series out with that automated
> script, so they all got sent basically at the same timestamp, and they
> are in the wrong order in my mailbox because email isn't that ordered.

Interesting.  What I received here from the mailing list from Arnd
was:

Date: Tue,  7 May 2013 18:02:09 +0200
Subject: [GIT PULL] ARM: Third batch of arm-soc changes for 3.10

Date: Tue,  7 May 2013 18:02:10 +0200
Subject: [GIT PULL] ARM: arm-soc platform updates for 3.10, part 2

Date: Tue,  7 May 2013 18:02:11 +0200
Subject: [GIT PULL] ARM: arm-soc platform updates for 3.10, part 3

Date: Tue,  7 May 2013 18:02:12 +0200
Subject: [GIT PULL] ARM: arm-soc device tree changes, part 2

Date: Tue,  7 May 2013 18:02:13 +0200
Subject: [GIT PULL] ARM: arm-soc: late cleanups

Date: Tue,  7 May 2013 18:02:14 +0200
Subject: [GIT PULL] ARM: arm-soc: late Exynos multiplatform changes

So they do each have a different timestamp, and do come out right if
sorted by date-sent.  Maybe one second is not long enough for gmail to
sort by date-sent?  Sure, allowing a longer delay reduces the
possibility of stuff being reordered by MTAs, but it will never totally
eliminate that reordering - it just makes it less likely.

FWIR, gmail orders messages by order-of-reception only, not by
date-anything, which makes using delays to try to anticipate the
order of reception quite fruitless.  And I suspect gmail doesn't show
you seconds (let alone give you Date: header.)

So I don't think that asking people to play games with delays between
consecutive messages is going to work all that well.

The only sure way would be to have it clearly marked in the subject
line, maybe in a similar way to how we mark patches using a
[GIT PULL N/M] thing.
