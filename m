From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 May 2013 10:03:36 +0100
Subject: [PATCH] ASoC: Samsung: i2s: Fix crash in i2s driver
In-Reply-To: <1367897941-18439-1-git-send-email-padma.v@samsung.com>
References: <1367897941-18439-1-git-send-email-padma.v@samsung.com>
Message-ID: <20130507090336.GP7478@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 07, 2013 at 09:09:01AM +0530, Padmavathi Venna wrote:
> This patch fixes a null pointer deference in i2s driver in DT
> case
> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
> 
> This patch is dependent on below patch posted by Thomas Abraham.
> https://patchwork.kernel.org/patch/2224801/

Please don't submit patches that can't be applied, the two patches need
to be submitted together.  Please also remember to include human
readable descriptions of patches in e-mails for the benefit of human
readers, commit IDs and URLs aren't immediately comprehensible.

Please further note my new e-mail address.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130507/79a558c2/attachment.sig>
