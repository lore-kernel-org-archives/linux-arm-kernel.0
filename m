From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Feb 2018 13:00:58 +0000
Subject: [PATCH 0/5] Arm interconnect PMU driver tidyup
In-Reply-To: <cover.1517855839.git.robin.murphy@arm.com>
References: <cover.1517855839.git.robin.murphy@arm.com>
Message-ID: <20180215130057.GB16623@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 05, 2018 at 06:39:41PM +0000, Robin Murphy wrote:
> Since system PMUs now have a proper home in drivers/perf/, let's
> collect together the Arm interconnect PMU drivers currently squatting
> in drivers/bus/. Whilst elbow-deep in the CCI driver I spotted some
> further opportunity for cleanup, so a few bonus patches are included
> at the end. 

For patches 1, 3-5:

Acked-by: Will Deacon <will.deacon@arm.com>

I'm assuming you'll route this via arm-soc.

Will
