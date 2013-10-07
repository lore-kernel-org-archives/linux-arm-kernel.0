From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Sun, 6 Oct 2013 23:18:47 -0700
Subject: [PATCH stable] ARM: tegra: unify Tegra's Kconfig a bit more
In-Reply-To: <20131005233833.GA18223@kroah.com>
References: <1380917411-25869-1-git-send-email-swarren@wwwdotorg.org>
 <20131005233833.GA18223@kroah.com>
Message-ID: <52525247.9060609@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 10/05/2013 04:38 PM, Greg KH wrote:
> On Fri, Oct 04, 2013 at 02:10:11PM -0600, Stephen Warren wrote:
>> [auto-builders for 3.11.x are failing due to this]
> What autobuilders?  I haven't heard of this before.

There's an experimental system here that automatically builds and 
test-boots -stable kernels on some Tegra platforms.  The output isn't 
public yet -- that's planned, but there are still a few bugs left in the 
test system that would be good to clean up first.

The output is similar to this:

http://nvt.pwsan.com/pub/linux/testlogs/

Will certainly send you a link when it's ready to go.


- Paul
