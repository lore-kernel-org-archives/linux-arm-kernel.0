From: mgreer@animalcreek.com (Mark A. Greer)
Date: Tue, 26 Feb 2013 15:52:05 -0700
Subject: crypto: omap-sham, omap-aes and dma_request_slave_channel_compat()
In-Reply-To: <512D00BE.8090204@canonical.com>
References: <512D00BE.8090204@canonical.com>
Message-ID: <20130226225205.GA13338@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[CC'ing more people & lists.]

On Tue, Feb 26, 2013 at 11:36:46AM -0700, Tim Gardner wrote:
> Whats up with commits 0e87e73f4abe1ada69cf780fe2550c6361a1b53b and
> b4b87a934c30fb91cbdd18ae028acdc361e1cf0f. As far as I can tell,
> dma_request_slave_channel_compat() does not exist in 3.9 as of
> 52caa59ed335616c5254adff7911465a57ed9f14, nor does it exist in
> linux-next as of Feb 26. Am I just being dense ?

Yeah, order got a little messed up.  The problem is known and the
sub-thread talking about it starts about here:

	http://www.spinics.net/lists/arm-kernel/msg225241.html

with the conclusion (AFAICT) that Vinod is to push it:

	http://www.spinics.net/lists/arm-kernel/msg226062.html

> Reverting those 2 commits at least allows the compile complete.

When the dependencies are sorted out, will you revert the revert
or do I need to do something?

Mark
--
