From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 10 Oct 2013 16:11:35 -0700
Subject: [PATCH stable] ARM: tegra: unify Tegra's Kconfig a bit more
In-Reply-To: <52539F98.2030307@nvidia.com>
References: <1380917411-25869-1-git-send-email-swarren@wwwdotorg.org>
 <20131005233833.GA18223@kroah.com> <52525247.9060609@nvidia.com>
 <52539F98.2030307@nvidia.com>
Message-ID: <20131010231135.GF4301@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 11:00:56PM -0700, Paul Walmsley wrote:
> 
> On 10/06/2013 11:18 PM, Paul Walmsley wrote:
> >Hi Greg,
> >
> >On 10/05/2013 04:38 PM, Greg KH wrote:
> >>On Fri, Oct 04, 2013 at 02:10:11PM -0600, Stephen Warren wrote:
> >>>[auto-builders for 3.11.x are failing due to this]
> >>What autobuilders?  I haven't heard of this before.
> >There's an experimental system here that automatically builds and
> >test-boots -stable kernels on some Tegra platforms.
> 
> Well, here's a public link for it:
> 
> http://nvt.pwsan.com/pub/linux-stable/testlogs/
> 
> So far it's seeded with v3.11.[34].  It should update automatically
> as new releases come out.  So far the tests are quite basic (build +
> boot to minimal userspace).  Please let Stephen and I know if you
> have any comments or suggestions.

That's great to see.  Testing the -rc stable releases would be great, to
find if I break anything, as I don't have Tegra hardware to test them
out on.

thanks,

greg k-h
