From: levinsasha928@gmail.com (Sasha Levin)
Date: Tue, 21 Jun 2011 23:11:27 -0400
Subject: [RFC 7/8] drivers: introduce rpmsg, a remote-processor
	messaging bus
In-Reply-To: <87liwu8u3q.fsf@rustcorp.com.au>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-8-git-send-email-ohad@wizery.com>
	<87liwu8u3q.fsf@rustcorp.com.au>
Message-ID: <1308712287.11435.4.camel@lappy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-06-22 at 12:12 +0930, Rusty Russell wrote:
> > +#define VIRTIO_ID_RPMSG		10 /* virtio remote processor messaging */
> 
> I think you want 6.  Plan 9 jumped ahead to grab 9 :)

Maybe it's worth adding an appendix to the virtio spec as part of this
(and really any) patch series which takes a virtio ID.

Also, I understand that virtio itself as an idea isn't Linux specific,
but maybe it's worth including the spec (or at least a variation of it)
as part of the kernel documentation.

-- 

Sasha.
