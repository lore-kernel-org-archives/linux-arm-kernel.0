From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Feb 2014 15:57:15 -0800
Subject: [PATCH] ARM: tegra: fix RTC0 alias for Cardhu
In-Reply-To: <1392337106-20584-1-git-send-email-swarren@wwwdotorg.org>
References: <1392337106-20584-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140218235715.GA25055@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 05:18:26PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This alias entry was evidently cut/paste from a different board, and
> not correctly updated to match Cardhu. Fix this.
> 
> Fixes: 553c0a200e20 ("ARM: tegra: set up /aliases entries for RTCs")
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This is a fix for v3.14-rc*

Applied.


-Olof
