From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 3 Jan 2016 19:55:19 +0100
Subject: [PATCH 04/10] i2c: st: use to_platform_device()
In-Reply-To: <18b3804a2b8d7c682f3f25951309e1503d8ab6d0.1451221174.git.geliangtang@163.com>
References: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
 <18b3804a2b8d7c682f3f25951309e1503d8ab6d0.1451221174.git.geliangtang@163.com>
Message-ID: <20160103185519.GJ1522@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 27, 2015 at 09:15:42PM +0800, Geliang Tang wrote:
> Use to_platform_device() instead of open-coding it.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160103/8a2663c9/attachment.sig>
