From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 13 Jan 2015 13:35:40 +0200
Subject: [PATCH v2] video: vt8500lcdfb: remove unneeded continue
In-Reply-To: <1420608948-4550-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1420608948-4550-1-git-send-email-sudipm.mukherjee@gmail.com>
Message-ID: <54B5030C.2050504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/15 07:35, Sudip Mukherjee wrote:
> continue is not needed at the end of a for loop, also removed the
> braces which were no longer required.
> 

Thanks, queued for 3.20.

 Tomi



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150113/1fb5e8f5/attachment.sig>
