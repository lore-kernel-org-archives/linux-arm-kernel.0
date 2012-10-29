From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Oct 2012 11:06:36 -0600
Subject: [PATCH 1/3] ARM: timer: fix checkpatch warnings
In-Reply-To: <1351016892-21211-1-git-send-email-swarren@wwwdotorg.org>
References: <1351016892-21211-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <508EB79C.1070805@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2012 12:28 PM, Stephen Warren wrote:
> This prevents checkpatch complaining when this file is moved in a later
> patch.

I have applied patches 1 and 2 to Tegra's tree for 3.8. I'll hold off on
patch 3 for a bit. I need to see if it could benefit from similar rework
that drivers/irqchip recently received from Thomas Petazzoni.
