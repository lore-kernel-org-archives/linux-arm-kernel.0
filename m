From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 09 Jul 2014 22:16:29 +0200
Subject: [RFC v2 0/5] Per-user clock constraints
In-Reply-To: <1404398323-18934-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1404398323-18934-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <53BDA31D.40502@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomeu,

On 03.07.2014 16:38, Tomeu Vizoso wrote:
> Hello,
> 
> here is another round for commenting, not very different from the first one.
> 
> Something I forgot to mention before is that the function rename was performed
> by the scripts in:
> 
> http://cgit.collabora.com/git/user/tomeu/linux.git/commit/?h=clk-refactoring-4&id=0e983e28864229f2cd525f87d59e034c4876b233
> 
> As before, I have only checked that drivers/clk/ builds with allyesconfig, and
> that a kernel can be built for tegra_defconfig.

This is quite an interesting series. I have reviewed two of five patches
and have plans to look at remaining ones, however here are few general
issues I'd like to raise:

- somehow I don't see patch 2/5 on LAKML. Too big?

- I see the series changing particular clock drivers. A good practice
would be to Cc respective driver maintainers to take a look at those
changes.

- please make sure that all the patches don't have checkpatch errors or
significant warnings.

Will try (myself or by asking someone else) to do some testing on
Samsung platforms.

Best regards,
Tomasz
