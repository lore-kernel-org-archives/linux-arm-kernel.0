From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 14:49:38 -0800
Subject: [GIT PULL 1/4] omap soc changes for v4.5 merge window
In-Reply-To: <567869ec.c694420a.6ab0f.7fabSMTPIN_ADDED_BROKEN@mx.google.com>
References: <567869ec.c694420a.6ab0f.7fabSMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <20151222224938.GH30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 01:06:34PM -0800, Tony Lindgren wrote:
> The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4:
> 
>   Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.5/soc-initcall
> 
> for you to fetch changes up to f2e6a0a913b53f5af87c7e9a783ceae5bb4ae2c4:
> 
>   ARM: OMAP2+: Remove device creation for omap-pcm-audio (2015-12-17 10:34:41 -0800)
> 
> ----------------------------------------------------------------
> SoC changes for omaps for v4.5 merge window. The main change here is to
> change the omap initcall levels a bit to initialize things later to allow
> early device drivers at core_initcall level. This makes things easier
> for us as most clocks can be made into regular device drivers except for
> a few early clocks needed to initialize system timers. I wanted to have
> these changes sit in Linux next for a few weeks before sending out a pull
> request, and so far now issues have showed up.
> 
> The other changes in this series are timer changes for making use of the
> new PWM driver, and timer changes to support more high security SoCs.
> Also few minor improvments for module autoidle settings for ti81xx spinbox
> and dra7 debug on uart4 in hwmod code. The rest is pretty much just removal
> of platform data for SoCs that are all device tree only nowadays.

Thanks, merged.


-Olof
