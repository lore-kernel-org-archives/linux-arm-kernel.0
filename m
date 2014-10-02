From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 2 Oct 2014 12:51:04 +0200
Subject: [PATCH] ARM: tegra: Move AHB Kconfig to drivers/amba
In-Reply-To: <5408BF77.1020007@wwwdotorg.org>
References: <1406643934-16301-1-git-send-email-thierry.reding@gmail.com>
 <53D7C9EE.60503@wwwdotorg.org> <53FB7288.9050002@wwwdotorg.org>
 <5408BF77.1020007@wwwdotorg.org>
Message-ID: <20141002105103.GA13906@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 04, 2014 at 01:37:27PM -0600, Stephen Warren wrote:
> On 08/25/2014 11:29 AM, Stephen Warren wrote:
> >On 07/29/2014 10:21 AM, Stephen Warren wrote:
> >>On 07/29/2014 08:25 AM, Thierry Reding wrote:
> >>>From: Thierry Reding <treding@nvidia.com>
> >>>
> >>>This will allow the Kconfig option to be shared among 32-bit and 64-bit
> >>>ARM.
> >>
> >>This seems fine to me. I'd expect to apply it for 3.18, provided I get
> >>an ack from Russell as drivers/amba maintainer (hence CCing him without
> >>trimming the quote).
> >
> >Russell,
> >
> >Are you OK with this patch? If so, if you could ack it so I can apply
> >it, that would be great.
> 
> Russell?

Russell,

Can I have your Acked-by on this or would you prefer it to be submitted
to the patch tracker? Would the patch tracker be the correct place also
for non-ARM core patches?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141002/d52410eb/attachment-0001.sig>
