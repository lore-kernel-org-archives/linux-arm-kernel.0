From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Nov 2012 11:12:43 -0700
Subject: [PATCH] ARM: tegra: whistler: enable HDMI port
In-Reply-To: <1353088465-25556-1-git-send-email-swarren@wwwdotorg.org>
References: <1353088465-25556-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <50A6821B.7090303@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2012 10:54 AM, Stephen Warren wrote:
> Enable host1x, and the HDMI output. Whistler also has a DSI-based LCD,
> and a VGA output. tegradrm doesn't support either of those output types
> yet.
> 
> Based on work by Thierry Reding for TrimSlice.

I have applied this to Tegra's for-3.8/dt branch.
