From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 15 Aug 2016 00:17:20 +0200
Subject: [PATCH] i2c: don't print error when adding adapter fails
In-Reply-To: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
Message-ID: <20160814221719.GA10501@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 01:36:16PM +0200, Wolfram Sang wrote:
> Since v4.8-rc1, the I2C core will print detailed information when adding an I2C
> adapter fails. So, drivers can skip this now.
> 
> I am still undecided if I apply this as a single patch or break it out. But for
> reviewing, avoiding the patch bomb is probably a good thing.
> 
> Should go via subsystem tree, I'd think.
> 
> Wolfram Sang (1):
>   i2c: don't print error when adding adapter fails
> 

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160815/1ec8f886/attachment.sig>
