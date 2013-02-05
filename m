From: js@sig21.net (Johannes Stezenbach)
Date: Tue, 5 Feb 2013 12:39:29 +0100
Subject: [RFC PATCH 0/4] Add support for LZ4-compressed kernels
In-Reply-To: <20130204105052.GA17786@n2100.arm.linux.org.uk>
References: <1359179447-31118-1-git-send-email-kyungsik.lee@lge.com>
 <20130128142510.68092e10.akpm@linux-foundation.org>
 <alpine.LFD.2.02.1301282320430.6300@xanadu.home>
 <20130130102353.GA8925@sig21.net> <510F16C9.2060901@oberhumer.com>
 <20130204105052.GA17786@n2100.arm.linux.org.uk>
Message-ID: <20130205113929.GA18049@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 10:50:52AM +0000, Russell King - ARM Linux wrote:
> On Mon, Feb 04, 2013 at 03:02:49AM +0100, Markus F.X.J. Oberhumer wrote:
> > At least akpm did approve the LZO update for inclusion into 3.7, but the code
> > still has not been merged into the main tree.
> >   > On 2012-10-09 21:26, Andrew Morton wrote:
> >   > [...]
> >   > The changes look OK to me.  Please ask Stephen to include the tree in
> >   > linux-next, for a 3.7 merge.
> > 
> > Well, this probably means I have done a rather poor marketing.
> 
> I assume this code is sitting in *your* tree?  How do you think it gets
> into mainline?
> 
> There is no automatic way that code from linux-next gets merged into
> mainline.  That is up to the tree owner to make happen, either by getting
> their tree into a parent maintainers tree, or if there is none, asking
> Linus to pull your tree at the appropriate time.

My feeling is that in this case it is unneccessarily hard
for an outside contributor to get a patch accepted, all
because get_maintainer.pl doesn't put someone in charge.

Apparently it doesn't work to put all the usual maintainer
responsibilities onto the shoulders of a Linux development novice.
Thus it would be nice if some maintainer would come
forward and offer to handle the patches for Markus.


Thanks,
Johannes
