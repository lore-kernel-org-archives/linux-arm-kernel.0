From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 15 Oct 2015 13:44:38 +0200
Subject: [PATCH v3] i2c: s3c2410: enable RuntimePM before registering to
 the core
In-Reply-To: <1444461874-2841-1-git-send-email-wsa@the-dreams.de>
References: <1444461874-2841-1-git-send-email-wsa@the-dreams.de>
Message-ID: <20151015114438.GD1546@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 10, 2015 at 08:24:23AM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> The core may register clients attached to this master which may use
> funtionality from the master. So, RuntimePM must be enabled before, otherwise
> this will fail. While here, move drvdata, too.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151015/a12f9049/attachment.sig>
