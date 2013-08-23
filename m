From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 23 Aug 2013 10:09:16 +0200
Subject: [PATCH v7] ARM: dts: mvebu: Introduce a new compatible string
 for mv64xxx-i2c
In-Reply-To: <1377243174-15877-1-git-send-email-gregory.clement@free-electrons.com>
References: <1377243174-15877-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130823080916.GA3035@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 09:32:54AM +0200, Gregory CLEMENT wrote:
> The mv64xxx-i2c embedded in the Armada XP have a new feature to
> offload i2c transaction. This new version of the IP come also with
> some errata. This lead to the introduction to a another compatible
> string.
> 
> This commit updates the Device Tree binding documentation accordingly.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130823/ed1612ea/attachment.sig>
