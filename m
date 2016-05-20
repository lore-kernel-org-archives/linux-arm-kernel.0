From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 20 May 2016 06:12:59 +0200
Subject: 4.5-rc0 regression: GPRS breaks after very short while
In-Reply-To: <20160518201251.GA22015@amd>
References: <20160518074924.GA20652@amd> <20160518141624.GA8025@earth>
 <20160518201251.GA22015@amd>
Message-ID: <20160520041258.GB22076@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 18, 2016 at 10:12:51PM +0200, Pavel Machek wrote:
> > The last one only changes a comment, so not relevant, the other
> > two fix error handling during initialization and are most likely
> > also not the problem. Can you try to bisect the problem?
> 
> It will not be fun, but I guess it is doable. But before I start it
> would be good to know -- does it work for you?

I currently don't have a second SIM card with network access for my
dev phone, so I usually only test without gprs connection. As a
result I don't really know if longer data connection would work.

Also I'm quite busy until next weekend with other stuff. If you did
not find anything until then, I will do some testing/debugging.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160520/e1685193/attachment.sig>
