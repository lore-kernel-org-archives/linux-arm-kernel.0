From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 18 May 2012 16:50:00 -0600 (MDT)
Subject: [PATCH 0/3] OMAP: control: bootaddr and bootmod APIs
In-Reply-To: <1336011113-31502-1-git-send-email-omar.luna@linaro.org>
References: <1336011113-31502-1-git-send-email-omar.luna@linaro.org>
Message-ID: <alpine.DEB.2.00.1205181649410.24735@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Omar,

On Wed, 2 May 2012, Omar Ramirez Luna wrote:

> Recently a patch went in for tidspbridge code, to ioremap
> SCM registers and solve a build break[1]. However it has
> been pointed out before that this is a layer violation
> given that control module should handle its own registers, this
> series is an attempt to create APIs for the users of these
> registers.
> 
> With some adaptations this patch might also make use of it:
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg66491.html
> 
> Patch: staging: tidspbridge: use scm functions to set boot address and mode,
> will be sent separately to staging tree.
> 
> Tested on OMAP3 Beagleboard.
> 
> [1] http://www.mail-archive.com/devel at linuxdriverproject.org/msg18762.html
> 
> Omar Ramirez Luna (3):
>   OMAP2+: control: new APIs to configure boot address and mode
>   OMAP: dsp: interface to control module functions
>   staging: tidspbridge: use scm functions to set boot address and mode

Thanks, queued for 3.6.

- Paul
