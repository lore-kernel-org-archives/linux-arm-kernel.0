From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 25 Apr 2011 11:32:24 -0700
Subject: [PATCH 0/4] Tegra patches for 2.6.40
In-Reply-To: <1303408892-7472-1-git-send-email-swarren@nvidia.com>
References: <1303408892-7472-1-git-send-email-swarren@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04973BBB14@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote at Thursday, April 21, 2011 12:01 PM:
> Below are the patches I have queued up for Tegra in 2.6.40.
> ...
> I tested:
> 
> * After applying these changes, everything builds OK and runs fine on
>   Harmony, including audio.
> * After additionally merging Mark's ASoC for-2.6.40/for-next branch,
>   there are no merge conflicts, everything builds OK, and everything
>   runs OK on Seaboard clamshell, including a full audio checkout.

>   Note that non-clamshell Seaboard has difficulty initializing I2C.
>   I'm investigating this, but don't expect to need to modify any of
>   these changes because of this issue; most likely some unrelated bug
>   needs fixing.

Note that I found the cause of this; please see my recent email titled
"[PATCH] i2c: tegra: Enable new slave mode." for this fix for this.

Thanks.

-- 
nvpublic
