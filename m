From: mporter@linaro.org (Matt Porter)
Date: Fri, 13 Dec 2013 14:19:26 -0500
Subject: [PATCH v3] ARM: bcm: Add DEBUG_LL console support
In-Reply-To: <1380987809-4886-1-git-send-email-bcm@fixthebug.org>
References: <1380987809-4886-1-git-send-email-bcm@fixthebug.org>
Message-ID: <20131213191926.GF23499@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 05, 2013 at 08:43:29AM -0700, Christian Daudt wrote:
> This patch adds low level debug uart support to Broadcom
>  mobile based SOCs.
> 
> Signed-off-by: Christian Daudt <bcm@fixthebug.org>
> 
> Changes from V2:
>  - Changed to follow hex ordering on entries
>  - Dropped defconfig changes
> 
> Changes from V1:
>  - Switched to use the common 8250 debug introduced in 3.12-rc1
> 

Also working for me on my Capri board.

Tested-by: Matt Porter <mporter@linaro.org>

-Matt
