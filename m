From: olof@lixom.net (Olof Johansson)
Date: Thu, 11 Apr 2013 03:02:22 -0700
Subject: [PATCH] ARM: vexpress: Remove A9 PMU compatible values for
 non-A9 platforms
In-Reply-To: <1365513470-2680-1-git-send-email-pawel.moll@arm.com>
References: <1365513470-2680-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20130411100222.GG31465@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 02:17:50PM +0100, Pawel Moll wrote:
> The ARM perf core code used to rely on the pmu node being
> compatible with "arm,cortex-a9-pmu", even when the PMUs
> of the different Cortex-A processors are not really
> compatible... This is no longer required and actually
> became harmful, so remove all the offending values
> from Versatile Express DTS files.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
> Hello Arnd, Olof,
> 
> Could you please add this patch to your fixes branch for 3.10 or
> to pull from the tag below?

Hi,

Please base all branches on a full -rc. To avoid respinning just for one patch
in this case, I just cherry-picked it in instead.

It's applied to next/fixes-non-critical.

Thanks!


-Olof
