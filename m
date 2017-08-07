From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Aug 2017 19:34:12 +0100
Subject: [PATCH 0/6] arm64 pmem support
In-Reply-To: <cover.1500397441.git.robin.murphy@arm.com>
References: <cover.1500397441.git.robin.murphy@arm.com>
Message-ID: <20170807183411.GD29632@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 11:55:37AM +0100, Robin Murphy wrote:
> With the latest updates to the pmem API, the arch code contribution
> becomes very straightforward to wire up - I think there's about as
> much code here to just cope with the existence of our new instruction
> as there is to actually make use of it. I don't have access to any
> NVDIMMs nor suitable hardware to put them in, so this is written purely
> to spec - the extent of testing has been the feature detection on a
> v8.2 Fast Model vs. v8.0 systems.
> 
> Patch #1 could go in as a fix ahead of the rest; it just needs to come
> before patch #5 to prevent that blowing up the build.

Modulo my two comments:

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
