From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Aug 2015 12:00:41 +0100
Subject: [PATCH 3/3] spi: s3c24xx: Convert spinlock to mutex
In-Reply-To: <1438668598-6678-3-git-send-email-drinkcat@chromium.org>
References: <1438668598-6678-1-git-send-email-drinkcat@chromium.org>
 <1438668598-6678-3-git-send-email-drinkcat@chromium.org>
Message-ID: <20150804110040.GJ20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 04, 2015 at 02:09:58PM +0800, Nicolas Boichat wrote:
> bitbang->lock is now a mutex: replace spinlock function calls
> by mutex functions.

This would need to be combined with the first patch, individual patches
shouldn't break the build.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150804/c4a9c636/attachment.sig>
