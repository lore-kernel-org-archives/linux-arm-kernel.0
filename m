From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 26 Oct 2017 09:08:15 +0200
Subject: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
In-Reply-To: <3dbb966f-c279-2c57-d3c2-98ca7c04accd@gmail.com>
References: <20171025203459.GA22035@amd>
 <3dbb966f-c279-2c57-d3c2-98ca7c04accd@gmail.com>
Message-ID: <20171026070815.GA20634@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2017-10-26 08:25:02, Filip Matijevi? wrote:
> Hi Pavel,
> 
> On 10/25/2017 10:34 PM, Pavel Machek wrote:
> > 3.5.3-nemo kernel seems to work
> 
> I did take a quick look at the board-rm680.c since there are some
> conditional statements with regards to system revision but I didn't
> notice anything that might prevent it from booting.

Thanks.

> > If you have
> > any ideas, let me know.
> 
> Last time I couldn't get output on serial I used CONFIG_DEBUG_LL,
> CONFIG_DEBUG_OMAP3UART3, CONFIG_EARLY_PRINTK... and ignore_loglevel
> earlyprintk kernel params to get output early enough - I guess you
> already tried that.

I realized I'm not getting output from the decompessor (even on "S"
machine), and enabled that.

But I'm _still_ not getting any output on decompressor... early
printing works ok on "S" but not on "P".

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171026/d9b11115/attachment.sig>
