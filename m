From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 23 Jul 2013 08:37:49 -0700
Subject: [PATCH v2 0/4] Add PWM polarity flag macro for DT
In-Reply-To: <10033310.z2U2FSCElN@avalon>
References: <1374101664-21112-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <51E81E1C.20708@wwwdotorg.org> <10033310.z2U2FSCElN@avalon>
Message-ID: <20130723153748.GC2066@dhcp-172-17-186-34.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 01:29:13PM +0200, Laurent Pinchart wrote:
> Hi Stephen,
> 
> On Thursday 18 July 2013 10:55:56 Stephen Warren wrote:
> > On 07/17/2013 04:54 PM, Laurent Pinchart wrote:
> > > Hello,
> > > 
> > > Here's a small patch set that replaces PWM polarity numerical constants
> > > with macros in DT.
> > 
> > The series,
> > Reviewed-by: Stephen Warren <swarren@nvidia.com>
> > 
> > I'm (very very) slightly hesitant about patch 3/4, since it's moving towards
> > all PWMs having to use the same specifier format, whereas specifiers are at
> > least potentially binding-specific, not device-type-specific. However,
> > consistency is good; there's no need to do something different just for the
> > heck of it. Equally, there's nothing actually stopping a new binding from
> > defining its own format rather than simply deferring to pwm.txt if it
> > absolutely has to, so I think this will turn out fine.
> 
> Exactly, that's why I don't think it's an issue. pwm.txt defines a common 
> format, individual bindings are free to use it or not.
> 
> Thierry, if you're fine with the patches, could you take them in your tree 
> with Stephen's Reviewed-by, or should I report them and send you a pull 
> request ?

They look good to me. I'll take them into my tree and add Stephen's
Reviwed-by. It might take me another week, though, as I'm currently
rather busy with other things.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130723/07ae3e46/attachment-0001.sig>
