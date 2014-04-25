From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 24 Apr 2014 23:35:09 -0700
Subject: [PATCH] Input: atkbd - fix keyboard LG Electronics
In-Reply-To: <1398351432-5361-1-git-send-email-ssl@chromium.org>
References: <1398351432-5361-1-git-send-email-ssl@chromium.org>
Message-ID: <20140425063509.GA10433@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 07:57:12AM -0700, Sheng-Liang Song wrote:
> After issuing ATKBD_CMD_RESET_DIS, LG Keyboard stop working.  The
> workaround is to remove ATKBD_CMD_RESET_DIS for LG Keyboards.
> 
> In order to keep the minimum changes to the current atkbd driver, I add
> logic to apply the patch if and only if the device is LG LW25-B7HV or
> P1-J273B.
> 
> Signed-off-by: Sheng-Liang Song <ssl@chromium.org>

Applied, thank you.

-- 
Dmitry
