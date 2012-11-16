From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Nov 2012 09:15:44 -0700
Subject: [PATCH 1/2] ARM: tegra: harmony: enable HDMI port
In-Reply-To: <1353021614-29200-1-git-send-email-swarren@wwwdotorg.org>
References: <1353021614-29200-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <50A666B0.6010605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2012 04:20 PM, Stephen Warren wrote:
> Enable host1x, and the HDMI output. Harmony also has an optional LCD,
> and a VGA output. The former isn't enabled due to potential issues with
> having multiple outputs enabled. The latter isn't enabled since the
> driver doesn't support VGA yet anyway.
> 
> Correct DDC I2C frequency to 100KHz.
> 
> Based on work by Thierry Reding for TrimSlice.

I have applied these two patches to Tegra's for-3.8/dt branch.
