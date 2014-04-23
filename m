From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Apr 2014 18:32:45 +0100
Subject: [PATCH v6 2/6] ARM: allow user access to arch timer virtual
 counter
In-Reply-To: <10ed3f4cfce13a80a9a3070934fc0e31619a1242.1398213562.git.nathan_lynch@mentor.com>
References: <cover.1398213562.git.nathan_lynch@mentor.com>
 <10ed3f4cfce13a80a9a3070934fc0e31619a1242.1398213562.git.nathan_lynch@mentor.com>
Message-ID: <20140423173244.GL5649@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 01:48:53AM +0100, Nathan Lynch wrote:
> As ARM64 does.  This is a necessary prerequisite for implementing
> gettimeofday and clock_gettime in a vdso.

Doesn't this change make arch_counter_set_user_access identical for arm and
arm64? In which case, we could move it into the driver itself.

Will
