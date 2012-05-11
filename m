From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Fri, 11 May 2012 14:39:22 +0000
Subject: [PATCH 0/5] more clk-next fixes
In-Reply-To: <CAJOA=zOeV9+1-oAwL-xYtwcz2SvhF_DuM=XENASywtpkzf0ttg@mail.gmail.com>
References: <1336367310-5140-1-git-send-email-mturquette@linaro.org>
 <CAJOA=zOeV9+1-oAwL-xYtwcz2SvhF_DuM=XENASywtpkzf0ttg@mail.gmail.com>
Message-ID: <201205111439.22834.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 May 2012, Turquette, Mike wrote:
> Arnd,
> 
> Please pull the following changes since commit
> 66f75a5d028beaf67c931435fdc3e7823125730c:
> 
>   Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)
> 
> are available in the git repository at:
>   git://git.linaro.org/people/mturquette/linux.git clk-next
> 

Hi Mike, sorry for the delay. Olof was handling the other
pull requests this week, and he probably didn't see this one
or the discussion leading up to it, because he was not on Cc.

I've pulled it into a next/clock branch now and it should
show up in the for-next branch when it gets rebuilt without
the spear patches that are currently in it and have older
confliction versions of some of the same patches.

	Arnd
