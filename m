From: greg@kroah.com (Greg KH)
Date: Tue, 6 Dec 2016 21:24:36 +0100
Subject: [stable:PATCH 0/3] PAN fixes backport for v4.4.35
In-Reply-To: <20161202164247.19496-1-james.morse@arm.com>
References: <20161202164247.19496-1-james.morse@arm.com>
Message-ID: <20161206202436.GB23027@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 04:42:44PM +0000, James Morse wrote:
> Hi linux-stable,
> 
> This is the backport of the recent PAN fixes series for v4.4.35.
> Original series:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-October/461806.html
> 
> Patch 1 changes the prototype of all the feature/errata enable calls, so
> is fiddly to backport, hence doing it later as a separate series.
> 
> Patch 3 has had the UAO desription removed from its commit message as
> v4.4 doesn't support this feature.

Thanks, now all queued up.

greg k-h
