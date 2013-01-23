From: anton@enomsg.org (Anton Vorontsov)
Date: Tue, 22 Jan 2013 22:25:06 -0800
Subject: [PATCH 23/24] ab8500-bm: Fix minor niggles experienced during
 testing
In-Reply-To: <20130122092717.GI6857@gmail.com>
References: <1358769840-4763-1-git-send-email-lee.jones@linaro.org>
 <1358769840-4763-24-git-send-email-lee.jones@linaro.org>
 <20130121191324.GA15037@lizard.mcd01528.sjc.wayport.net>
 <20130122092717.GI6857@gmail.com>
Message-ID: <20130123062506.GA20858@lizard.gateway.2wire.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 09:27:17AM +0000, Lee Jones wrote:
> On Mon, 21 Jan 2013, Anton Vorontsov wrote:
> 
> > On Mon, Jan 21, 2013 at 12:03:59PM +0000, Lee Jones wrote:
> > > When compile testing the new AB8500 Battery Management changes
> > > due for inclusion into upstream, there were a few minor niggles
> > > which required repairing, or adapting for use against the
> > > Mainline kernel. This patch is a collection of them all.
> > 
> > No. This is the third time I'm saying it: the last time I checked, this is
> > not how we do development in the mainline.
> 
> Okay, all of these changes have now been fixed-up into the patches
> which caused the issues. I have also added Stable to the patch you
> requested it on.
> 
> How would you like to proceed? Do you want a pull-request, or for me
> to send the patches to the list again?

Either way will work.

Thanks!

Anton

p.s. I took another look at the patches, and noticed one issue that is
constantly there: you place your signed-off-by line on top of everyones',
but that's wrong. Sign offs are going downwards, not upwards. This is
quite important since the lines encode how the code "travels" between
companies and submitters. Currently, one might assume that the origin of
the code is always Linaro, which is not quite true. (And 'From:' doesn't
always mean the author, fwiw.)
