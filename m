From: olof@lixom.net (Olof Johansson)
Date: Tue, 5 Jul 2016 22:32:55 -0700
Subject: [GIT PULL 1/2] omap soc updates for v4.8 merge window
In-Reply-To: <5774c688.0137620a.4e207.ffffb69fSMTPIN_ADDED_BROKEN@mx.google.com>
References: <5774c688.0137620a.4e207.ffffb69fSMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <20160706053255.GL23212@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 12:13:00AM -0700, Tony Lindgren wrote:
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.8/soc-signed
> 
> for you to fetch changes up to 44e7475d40eb26b8d3a6e2b2f7a5f12a5fe0942e:
> 
>   ARM: OMAP2+: Fix build if CONFIG_SMP is not set (2016-06-27 23:30:02 -0700)
> 
> ----------------------------------------------------------------
> SoC related changes for omaps for v4.8 merge window:
> 
> - A series of DSS platform_data fixes to prepare for DSS driver changes
> 
> - Add tblck clck aliases for PWM
> 
> - A series of trivial spelling corrections
> 
> - Remove bogus eQEP, ePWM and eCAP hwmod entries
> 
> - A series of McBSP sidetone fixes
> 
> - Remove QSPI and DSS addresses from hwmod, these come from dts
> 
> - Fix RSTST register offset for pruss
> 
> - Make ti81xx_rtc_hwmod static
> 
> - Remove wrongly defined RSTST offset for PER Domain, note
>   that the subject for this one wrongly has "dts" in the
>   subject
> 
> - Add support for omap5 and dra7 workaround for 801819
> 
> - A series of patches to make kexec work for SMP omaps

Merged, thanks.


-Olof
