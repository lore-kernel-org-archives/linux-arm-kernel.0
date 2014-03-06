From: mporter@linaro.org (Matt Porter)
Date: Thu, 6 Mar 2014 04:00:13 -0500
Subject: [PATCH] mach-bcm: bcm281xx: symbol cleanup
In-Reply-To: <1393369305-4748-1-git-send-email-elder@linaro.org>
References: <1393369305-4748-1-git-send-email-elder@linaro.org>
Message-ID: <20140306090013.GF25092@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 05:01:45PM -0600, Alex Elder wrote:
> This patch renames a few symbols that needlessly used "11351" rather
> than "281xx" in their names.
> 
> Support for the bcm11351 board is being removed from the kernel, and
> the family of boards is more properly referred to as "bcm281xx".
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Applied to mach-bcm for-3.15/cleanup

-Matt
