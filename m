From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 21 Jan 2015 03:46:27 +0100
Subject: [PATCH] power/reset: vexpress: Remove non-DT code
In-Reply-To: <1421774642-29843-1-git-send-email-pawel.moll@arm.com>
References: <1421774642-29843-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20150121024626.GA28669@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 20, 2015 at 05:24:02PM +0000, Pawel Moll wrote:
> Now, as all VE platforms have to be booted with DT,
> the code handling non-DT case can be removed.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Thanks, applied.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150121/d55b6111/attachment-0001.sig>
