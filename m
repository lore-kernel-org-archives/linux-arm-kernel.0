From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 30 Mar 2017 08:24:05 +0200
Subject: Including Alpine -next tree in linux-next
In-Reply-To: <20170330092902.49cb4d4f@canb.auug.org.au>
References: <20170329131201.j4e7cnmgufj2i7tr@kwain>
 <20170330001444.62ac2ad1@canb.auug.org.au>
 <20170329132148.fzn4pxc4523os4y7@kwain>
 <20170330092902.49cb4d4f@canb.auug.org.au>
Message-ID: <20170330062405.nioiwh57snmdiutt@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, Mar 30, 2017 at 09:29:09AM +1100, Stephen Rothwell wrote:
> On Wed, 29 Mar 2017 15:21:48 +0200 Antoine Tenart <antoine.tenart@free-electrons.com> wrote:
> > On Thu, Mar 30, 2017 at 12:14:54AM +1100, Stephen Rothwell wrote:
> > > On Wed, 29 Mar 2017 15:12:01 +0200 Antoine Tenart <antoine.tenart@free-electrons.com> wrote:  
> > > > Would it be possible to include Alpine's -next tree in linux-next?
> > > > 
> > > > Repo: https://git.kernel.org/pub/scm/linux/kernel/git/atenart/linux.git
> > > > Branch: alpine/for-next  
> > > 
> > > Could you give me a short idea about what this tree contains?  Also,
> > > whose tree will it be merged via (or does it go direct to Linus
> > > (Torvalds)?  
> > 
> > The Alpine SoCs are ARM and ARM64 processors. This branch will contain
> > patches we plan to send to arm-soc during their merge window. So mostly
> > device tree and SoC specific patches.
> > 
> > The patches will be merged through arm-soc before getting to Linus.
> 
> Included from today with just you as the contact.

Thanks!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170330/6076a457/attachment.sig>
