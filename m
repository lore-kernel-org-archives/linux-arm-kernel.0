From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 25 Sep 2012 10:56:29 +0200
Subject: [PATCH 2/6] ARM: dove: Fix tauros2 device tree init
In-Reply-To: <20120925051934.GJ14266@lunn.ch>
References: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1348531338-16624-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <5061073C.4010002@gmail.com> <20120925051934.GJ14266@lunn.ch>
Message-ID: <506171BD.8020207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2012 07:19 AM, Andrew Lunn wrote:
> Interestingly, kisskb does not show this break:
>
> http://kisskb.ellerman.id.au/kisskb/config/308/
>
> and yesterdays build does not have the parameter to tauros2_init().
> Is the cache not enabled in dove_defconfig?

Andrew,

I checked dove_defconfig and CONFIG_CACHE_TAUROS2 is not set.
I put it on my list for the next release cycle.

Interestingly, the mmp guys changed the parameter within
non-DT dove_init.

Sebastian
