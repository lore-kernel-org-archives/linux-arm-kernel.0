From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 15 Mar 2015 11:02:19 +0100
Subject: [PATCH 2/2] i2c: nomadik: match status to return type of read_i2c
In-Reply-To: <1423398883-24687-1-git-send-email-hofrat@osadl.org>
References: <1423398883-24687-1-git-send-email-hofrat@osadl.org>
Message-ID: <20150315100218.GD6770@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 08, 2015 at 07:34:43AM -0500, Nicholas Mc Guire wrote:
> return type of read_i2c() is int not u32. As the assignments to status
> are consistent with int here its type is changed to int.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150315/83f3b361/attachment-0001.sig>
