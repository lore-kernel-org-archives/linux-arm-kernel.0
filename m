From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 16 Jul 2015 22:40:19 +0200
Subject: [PATCH] i2c: s3c2410: remove unused variable
In-Reply-To: <1437078976-29145-1-git-send-email-laurent.navet@gmail.com>
References: <1437078976-29145-1-git-send-email-laurent.navet@gmail.com>
Message-ID: <20150716204019.GA1533@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 10:36:16PM +0200, Laurent Navet wrote:
> ret is assigned zero and just used to return. remove it.
> Found by using coccinelle.
> 
> Signed-off-by: Laurent Navet <laurent.navet@gmail.com>

Why not make it void?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150716/97a5b17e/attachment.sig>
