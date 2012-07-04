From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 4 Jul 2012 11:19:36 +0100
Subject: [PATCH] clk: wm831x: fix checkpatch issue for static const char
 * array
In-Reply-To: <1341395680-14142-1-git-send-email-Barry.Song@csr.com>
References: <1341395680-14142-1-git-send-email-Barry.Song@csr.com>
Message-ID: <20120704101936.GD4111@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2012 at 05:54:40PM +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> static const char * array should probably be static const char * const

We need some additional clock API patches to get merged before this is
OK, last time I checked the API wasn't const correct enough for it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120704/dc221aa9/attachment.sig>
