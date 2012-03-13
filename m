From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 13 Mar 2012 17:47:56 +0100
Subject: [PATCH 1/5 v4] i2c/gpio: add DT support
In-Reply-To: <20120313140822.GD2488@pengutronix.de>
References: <1331642024-19869-1-git-send-email-plagnioj@jcrosoft.com>
 <20120313140822.GD2488@pengutronix.de>
Message-ID: <20120313164756.GF18320@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:08 Tue 13 Mar     , Wolfram Sang wrote:
> On Tue, Mar 13, 2012 at 01:33:40PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > update to use devm_kzalloc for private data
> 
> Hmm, you need really to work on the commit messages, not everybody is
> familiar with DT and its implications:
> 
> "To achieve DT support, we need to populate a custom platform_data in a
> private struct from DT information. To simplify code, the adapter and
> algorithm are also put into the private struct."
> 
ok I put this can I get the Ack ?

I need to send the pull asap

Best Regards,
J.
