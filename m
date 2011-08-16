From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 15 Aug 2011 19:26:30 -0700
Subject: [PATCH v2] i2c: tegra: Check for overflow errors with BUG_ON.
In-Reply-To: <1313458336-31456-1-git-send-email-dianders@chromium.org>
References: <1313434172-18319-1-git-send-email-dianders@chromium.org>
	<1313458336-31456-1-git-send-email-dianders@chromium.org>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04AEA252A8@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug Anderson wrote at Monday, August 15, 2011 7:32 PM:
> This change doesn't fix any known problems but turns
> on the overflow detection feature of the i2c controller
> in the hopes of flushing out any current (or future)
> bugs in the i2c driver.
> 
> Inspired by a change on nvidia's git server:
>   http://nv-tegra.nvidia.com/gitweb/?p=linux-2.6.git;a=commit;h=266d1b7397284505e55d06254b497cb32be07b69
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
> This takes Felipe Balbi's suggestion of making the overflow
> error non-fatal.

This seems like a reasonable debug aid/validation check to me;
Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
