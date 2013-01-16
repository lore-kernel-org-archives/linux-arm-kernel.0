From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Tue, 15 Jan 2013 17:48:12 -0800
Subject: [PATCH 00/18] AB8500 battery management series upgrade
In-Reply-To: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
References: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20130116014812.GA27065@lizard.fhda.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 01:12:48PM +0000, Lee Jones wrote:
> Here we go again. This patches include your suggested fixups.
> 
> Please find the next instalment of the AB8500 Power drivers upgrade.
> A lot of work has taken place on the internal development track, but
> little effort has gone into mainlining it. At last count there were
> around 70+ patches which are in need of forward-porting, then
> upstreaming. This patch-set aims to make a good start. :)

All except 14/18 applied, thanks!

Some general notes:

- No need for the power: prefix in the subject, unless it is a core
  change;
- Try be consistent on the capitalization (I tend to capitalize the first
  word, "driver: Fix something". But it's up to you, just be consistent).
- Try keep the patches compilable. :)
- ..and applicable to the battery tree.

Thanks!

Anton

p.s. I'll push out the battery tree a bit later (in a couple of hours), so
don't worry if the commits won't appear just now.
