From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 5 Feb 2015 20:20:25 +0100
Subject: [PATCH] i2c: hix5hd2: add COMPILE_TEST
In-Reply-To: <1422696495-27282-1-git-send-email-zhangfei.gao@linaro.org>
References: <1422696495-27282-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20150205192025.GD15307@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 31, 2015 at 05:28:15PM +0800, Zhangfei Gao wrote:
> Commit 9439eb3ab9d1ec ("asm-generic: io: implement relaxed
> accessor macros as conditional wrappers") has added
> {read,write}{b,w,l,q}_relaxed to include/asm-generic/io.h.
> So COMPILE_TEST can be added.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150205/a7d0e1cf/attachment.sig>
