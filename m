From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Jan 2015 10:09:10 +0000
Subject: [PATCH v2 03/40] arm64/uaccess: fix sparse errors
In-Reply-To: <20150106215115.GA21594@redhat.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
 <1420558883-10131-4-git-send-email-mst@redhat.com>
 <20150106191432.GC32449@arm.com>
 <20150106214820.GA18895@redhat.com>
 <20150106215115.GA21594@redhat.com>
Message-ID: <20150107100910.GA7485@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 09:51:15PM +0000, Michael S. Tsirkin wrote:
> On Tue, Jan 06, 2015 at 11:48:20PM +0200, Michael S. Tsirkin wrote:
> > On Tue, Jan 06, 2015 at 07:14:32PM +0000, Will Deacon wrote:
> > > Hi Michael,
> > > 
> > > On Tue, Jan 06, 2015 at 03:43:40PM +0000, Michael S. Tsirkin wrote:
> > > > virtio wants to read bitwise types from userspace using get_user.  At the
> > > > moment this triggers sparse errors, since the value is passed through an
> > > > integer.
> > > > 
> > > > Fix that up using __force.
> > > > 
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > 
> > > > Acked-by: Will Deacon <will.deacon@arm.com>
> > > > ---
> > > 
> > > Did you want us to take this via the arm64 tree, or are you planning to
> > > merge it via another route?
> > > 
> > > Will
> > 
> > Up to you really: if you don't pick it up, Arnd said he'll merge
> > through his tree.
> 
> Though if you do pick it up, need to also pick up the follow-up
> patch - maybe my tree is easier.

Ok, I'll go ack that whitespace fix for you to take then.

Will
