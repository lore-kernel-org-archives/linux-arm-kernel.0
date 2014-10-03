From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Oct 2014 02:27:21 +0200
Subject: [PATCH] i2c: rk3x: fix 0 length write transfers
In-Reply-To: <1412185241-24950-1-git-send-email-amstan@chromium.org>
References: <1412185241-24950-1-git-send-email-amstan@chromium.org>
Message-ID: <20141003002721.GC1323@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 10:40:41AM -0700, Alexandru M Stan wrote:
> i2cdetect -q was broken (everything was a false positive, and no transfers were
> actually being sent over i2c). The way it works is by sending a 0 length write
> request and checking for NACK. This patch fixes the 0 length writes and actually
> sends them.
> 
> Reported-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Alexandru M Stan <amstan@chromium.org>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141003/13064511/attachment.sig>
