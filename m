From: sameo@linux.intel.com (Samuel Ortiz)
Date: Wed, 19 Jun 2013 10:23:48 +0200
Subject: [PATCH v2 0/5] mfd: twl4030-power: Start DT conversion and updates
In-Reply-To: <1371561480-28325-1-git-send-email-florian.vaussard@epfl.ch>
References: <1371561480-28325-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <20130619082348.GQ7161@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On Tue, Jun 18, 2013 at 03:17:55PM +0200, Florian Vaussard wrote:
> Hello,
> 
> This series enables a partial DT support for twl4030-power. The
> missing part is the power management scripts, as the required
> binding should be defined first. It however enables the complete
> shutdown of the processor at poweroff when booting with DT,
> dropping the power consumption from around 350 mA on Overo+Tobi
> to about 40 mA.
> 
> The poweroff callback was tested with both DT and non-DT boots.
> 
> The last two patches simplify the error path in the probe function,
> and fix registers relocking on error.
> 
> Best regards,
> 
> Florian
> 
> Since v1:
> - use module_platform_driver()
> - split the refactoring of the probe function into a dedicated patch
> - new patch to fix registers relocking on error
> - rebased on mfd-next
> 
> 
> Florian Vaussard (5):
>   mfd: twl4030-power: Split from twl-core into a dedicated module
>   mfd: twl4030-power: Simplify probing of power scripts and resources
>   mfd: twl4030-power: Start transition to DT
>   mfd: twl4030-power: Simplify error path
>   mfd: twl4030-power: Fix relocking on error
All 5 patches applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
