From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 13 Mar 2012 20:46:17 +0100
Subject: [PATCH 1/5 v4] i2c/gpio: add DT support
In-Reply-To: <20120313164756.GF18320@game.jcrosoft.org>
References: <1331642024-19869-1-git-send-email-plagnioj@jcrosoft.com>
 <20120313140822.GD2488@pengutronix.de>
 <20120313164756.GF18320@game.jcrosoft.org>
Message-ID: <20120313194616.GE2488@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 05:47:56PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 15:08 Tue 13 Mar     , Wolfram Sang wrote:
> > On Tue, Mar 13, 2012 at 01:33:40PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > 
> > > update to use devm_kzalloc for private data
> > 
> > Hmm, you need really to work on the commit messages, not everybody is
> > familiar with DT and its implications:
> > 
> > "To achieve DT support, we need to populate a custom platform_data in a
> > private struct from DT information. To simplify code, the adapter and
> > algorithm are also put into the private struct."
> > 
> ok I put this can I get the Ack ?

Yes.

> I need to send the pull asap

Please, no rush. Makes it too easy for bugs to slip in...

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120313/7cf3bc0a/attachment.sig>
