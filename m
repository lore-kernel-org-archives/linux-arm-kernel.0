From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 17 Jul 2014 12:02:41 +0200
Subject: [PATCH 2/2 v2] i2c: exynos5: remove extra line and fix an
 assignment
In-Reply-To: <1403759698-15624-2-git-send-email-ch.naveen@samsung.com>
References: <1403759698-15624-1-git-send-email-ch.naveen@samsung.com>
 <1403759698-15624-2-git-send-email-ch.naveen@samsung.com>
Message-ID: <20140717100241.GC2740@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 10:44:58AM +0530, Naveen Krishna Chatradhi wrote:
> This patch does the following in exynos5_i2c_message_start() function
> 1. Fixes an assignment
>    As, "i2c_auto_conf" is initialized to '0' at the beginning of the
>    function and HSI2C_READ_WRITE is defined as (1u << 16)
> 
>    Using "|=" for the first assignment is more readable.
> 
> 2. Removes an extra line 
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/b4f9cc30/attachment.sig>
