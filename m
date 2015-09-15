From: tony@atomide.com (Tony Lindgren)
Date: Tue, 15 Sep 2015 09:48:28 -0700
Subject: [GIT PULL] omap fixes against v4.3-rc1
In-Reply-To: <20150915154650.GS10928@atomide.com>
References: <20150915154650.GS10928@atomide.com>
Message-ID: <20150915164828.GB4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [150915 08:54]:
> 
> - Fix pbias regulator compatible values as a pending regulator
>   fix needs those for MMC1 to work properly

And when the pbias regulator fix hits mainline, I'll send
one more pull request to correct the reg entries for pbias
for the MMC hassles. Here's a summary FYI:

http://article.gmane.org/gmane.linux.kernel.mmc/33911

Regards,

Tony
