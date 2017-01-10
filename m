From: olof@lixom.net (Olof Johansson)
Date: Mon, 9 Jan 2017 19:21:20 -0800
Subject: [GIT PULL] Allwinner conversion to generic pin properties
In-Reply-To: <20161226074214.sd53ozm6hvzkdb26@lukather>
References: <20161226074214.sd53ozm6hvzkdb26@lukather>
Message-ID: <20170110032120.GJ22261@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 26, 2016 at 08:42:14AM +0100, Maxime Ripard wrote:
> Hi Arnd, Olof,
> 
> Like we discussed it last time, here is a pull request with the
> convertion patches to the generic pin properties for 4.10.
> 
> Thanks,
> Maxime
> 
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-generic-pinconf-for-4.10
> 
> for you to fetch changes up to 1edcd36fcb48fe841bcc62eda36c105037d9583c:
> 
>   ARM: sunxi: Convert pinctrl nodes to generic bindings (2016-12-26 08:27:11 +0100)
> 
> ----------------------------------------------------------------
> Allwinner conversion to generic pin muxing properties
> 
> Here is a list of patches that converts the current DT to the generic pin
> control and muxing properties, now that the pinctrl driver supports it.

I dropped the ball on this over the holidays for a few reasons, none of them
good. Unfortunately we're at -rc3+ now, so I've queued this up in next/dt for
v4.11 at this point. Hope that's alright.

You might want to use your branch as a base for new DT contents for
v4.11 in case it ends up being conflict-heavy, which would work fine at our
end.


Regards,

-Olof
