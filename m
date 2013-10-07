From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Oct 2013 09:51:33 -0700
Subject: [GIT PULL] ARM: provide common arch init for DT clocks for v3.13
In-Reply-To: <1380483490-12173-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1380483490-12173-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20131007165133.GD15413@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 29, 2013 at 09:38:10PM +0200, Sebastian Hesselbarth wrote:
> Arnd, Kevin, Olof,
> 
> please pull these patches for the arch-wide call to of_clk_init for v3.13.
> There are two dependencies for this patch set, one for tegra and one for nomadik.
> 
> The pull request for the tegra dependencies can be found here:
> http://www.spinics.net/lists/arm-kernel/msg273957.html
> 
> The patch for nomadik, that should hit before v3.13 can be found here:
> http://www.spinics.net/lists/arm-kernel/msg273376.html
> 
> As this is my first PR ever, please do not hesitate to report back any issues
> with this PR as soon as possible.

Thanks, I've merged this in. The only thing missing is a signed tag. I
stole your description from the 00/26 patch and used that.


-Olof
