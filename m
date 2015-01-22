From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 22 Jan 2015 15:18:24 +0100
Subject: [PATCH 1/1] i2c: i2c-st: Rename clock reference to something
 that exists
In-Reply-To: <1409234523-20240-1-git-send-email-lee.jones@linaro.org>
References: <1409234523-20240-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20150122141824.GB3413@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 03:02:03PM +0100, Lee Jones wrote:
> CLK_S_ICN_REG_0 hasn't existed for a while now.  This was renamed
> over a few commits, then finally removed in commit 5aa02b9 (ARM:
> STi: DT: STiH415: Remove unused CLK_S_ICN_REG_0 fixed clock).
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150122/b289f9de/attachment.sig>
