From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 10 Apr 2012 09:59:56 +0100
Subject: common clk: fix clk_register_fixed_rate() under memory pressure
In-Reply-To: <CAJOA=zNt7V_LNLAyXxJU2oS3vTEhvZ1JUWAx+hqQM1t=Whjr6w@mail.gmail.com>
References: <20120405084808.GA21060@glitch>
 <CAJOA=zNt7V_LNLAyXxJU2oS3vTEhvZ1JUWAx+hqQM1t=Whjr6w@mail.gmail.com>
Message-ID: <20120410085956.GA24465@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2012 at 02:52:15PM -0700, Turquette, Mike wrote:

> Thanks for the patch Domenico.  I did a big cleanup of the
> registration code for all of the basic clock types and a fix for this
> has already been rolled in to that branch, so I won't be taking this
> patch.  I'll Cc you on the fixes when I send them to the list
> (probably tomorrow).

Would it be possible for you to keep a tree in -next?  There's been
several people sending patches like this which have been superceeded by
your work and this might help avoid such duplicated work.
