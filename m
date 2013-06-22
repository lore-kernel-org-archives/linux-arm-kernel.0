From: marex@denx.de (Marek Vasut)
Date: Sat, 22 Jun 2013 15:23:15 +0200
Subject: [PATCH v1 02/12] input: matrix-keymap: func call coding style nit
In-Reply-To: <20130622082207.GC24305@book.gsilab.sittig.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <201306220418.59722.marex@denx.de>
 <20130622082207.GC24305@book.gsilab.sittig.org>
Message-ID: <201306221523.15431.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gerhard Sittig,

> On Sat, Jun 22, 2013 at 04:18 +0200, Marek Vasut wrote:
> > ret = matrix_keypad_map_key(input_dev, rows, cols, row_shift, key);
> > if (ret)
> > 
> > 	return ret;
> > 
> > Now that you return correct error codes from above, you should propagate
> > them through.
> 
> Will do, queued for v2.  Thank you for reviewing this.

Wait a little bit for some more feedback, esp. from the marvell guys ;-)

Best regards,
Marek Vasut
