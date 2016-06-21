From: olof@lixom.net (Olof Johansson)
Date: Mon, 20 Jun 2016 21:51:51 -0700
Subject: [GIT PULL] ARM: vexpress: fixes for v4.8
In-Reply-To: <57680186.7040105@arm.com>
References: <57680186.7040105@arm.com>
Message-ID: <20160621045151.GB24293@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 03:45:26PM +0100, Sudeep Holla wrote:
> Hi ARM-SoC team,
> 
> Here are the few changes for fixing build with W=1 option on Vexpress
> platforms for v4.8. Not sure whether this should be categorized as
> cleanups or fixes. Please pull !
> 
> -- 
> Regards,
> Sudeep
> 
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
> tags/vexpress-fixes-4.8
> 
> for you to fetch changes up to 0a14d280e17ef3db75254439dfc83f1bc65fca6f:
> 
>   power: vexpress: make dev_attr_active static (2016-06-13 09:55:51 +0100)

Merged, and I chose to do this into next/cleanup. Thanks for keeping it in a
separate branch to make that easy to do.


-Olof
