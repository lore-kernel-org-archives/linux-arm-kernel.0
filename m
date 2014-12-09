From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 9 Dec 2014 10:13:17 +0530
Subject: [PATCH v5 00/61] dmaengine: Implement generic slave capabilities
 retrieval
In-Reply-To: <20141208183853.GG8739@lukather>
References: <1416231775-31252-1-git-send-email-maxime.ripard@free-electrons.com>
 <20141208061746.GD16827@intel.com> <20141208141807.GC8739@lukather>
 <20141208162843.GP16827@intel.com> <20141208183853.GG8739@lukather>
Message-ID: <20141209044317.GU16827@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 07:38:53PM +0100, Maxime Ripard wrote:
> On Mon, Dec 08, 2014 at 09:58:43PM +0530, Vinod Koul wrote:
> I totally understand your point. And I actually am a bit uncomfortable
> merging this so late too, and I'd actually prefer to have it merged
> for 3.20. But this is a huge patchset, and I'd really like to avoid
> rebasing it forever.
> 
> I'll send a v6, with your patches, as soon as 3.19-rc1 is out. This
> will be my last rebase of this serie. If these patches are not merged
> then, then I will just give up on this cleanup, and probably any
> subsequent ones.
Since I have applied them to a topic branch, I don't think we you to rebase
and resend. Git does a pretty good job at rebasing so I will rebase
this branch on top of -rc1 and merge. Fixes can keep coming on top of this
one.

So these patches are applied, and will show up in -next after -rc1. Thank
you for the work you put in this.

Last night, I thought of giving it a try so temporarily merged this to my
next. SFR found bunch of issues with it (mostly due to dependencies in
users) so lets keep fixing those..

-- 
~Vinod

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141209/2ca8a18e/attachment-0001.sig>
