From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Wed, 27 Jun 2012 20:23:52 -0500
Subject: [PATCH 0/3] OMAP: hwmod: reset API proposal
In-Reply-To: <1339811681-5256-1-git-send-email-omar.luna@linaro.org>
References: <1339811681-5256-1-git-send-email-omar.luna@linaro.org>
Message-ID: <CALLhW=7jt3J2GwLgD57qCx+_hpw3y=0kADdU=_uYRajq5FQy+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 15 June 2012 20:54, Omar Ramirez Luna <omar.luna@linaro.org> wrote:
> Recent changes in omap_hwmod framework have reworked the behaviour
> towards hardreset handling, commit 747834a (ARM: OMAP2+: hwmod:
> revise hardreset behavior) recommends for drivers to implement
> their own reset sequences until code out-of-tree hits mainline
> and then their needs and code can be reviewed.
>
> Since it is not clear when this will occur for all drivers and
> hwmod code was not deleted (presumably because at some point it
> will handle the resets once again), this series exports functions
> to handle hardreset lines in an attempt to reduce code duplication
> for those who have a common reset sequence.
>
> These APIs are intended to be used by iommu for now, but were
> tested with IPU and remoteproc on Pandaboard.

Do you have any comments for these patches?

Regards,

Omar
