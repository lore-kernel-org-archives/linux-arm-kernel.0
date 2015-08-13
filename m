From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Aug 2015 14:27:55 +0200
Subject: [GIT PULL] omap gpmc null pointer fix against v4.2-rc6
In-Reply-To: <20150813082022.GL10928@atomide.com>
References: <20150813082022.GL10928@atomide.com>
Message-ID: <20150813122755.GB23581@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 01:20:22AM -0700, Tony Lindgren wrote:
> The following changes since commit cd4556733b30cc363adc7b1cea3bffa7e2dd0c7c:
> 
>   ARM: dts: dra7: Fix broken pbias device creation (2015-08-05 03:04:07 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/fixes-rc6
> 
> for you to fetch changes up to e984a1791ac6a7c944911207e8a9c344763f0003:
> 
>   memory: omap-gpmc: Don't try to save uninitialized GPMC context (2015-08-12 01:43:49 -0700)

Thanks, merged.


-Olof
