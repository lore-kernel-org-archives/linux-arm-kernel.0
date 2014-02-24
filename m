From: will.deacon@arm.com (Will Deacon)
Date: Mon, 24 Feb 2014 18:28:15 +0000
Subject: [PATCH 0/2] CCI PMU update
In-Reply-To: <1392812223-29274-1-git-send-email-punit.agrawal@arm.com>
References: <1392812223-29274-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <20140224182815.GA1198@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Olof and arm at kernel.org]

On Wed, Feb 19, 2014 at 12:17:01PM +0000, Punit Agrawal wrote:
> Here are a short couple of patches to update the CCI PMU perf backend
> to better support IP updates.
> 
> The first patch simplifies version checking to assume that event
> numbering doesn't change for > r1p0 (it changed between r0 and r1).
> This change should help reduce code churn when IP version is bumped up
> without any changes to event numbering.
> 
> The second patch exports the PMU version to userspace (via the PMU
> name) to allow tooling to deal with event numbering differences.
> 
> I'd appreciate any feedback on the changes.
> 
> The patches are based on top of 3.14-rc3 and can hopefully make it for
> 3.15.

Since these patches [1] are small and trivial, would the arm-soc folk be
happy picking them directly? I can put together a branch and pull request if
necessary, but it seems a bit OTT for this.

Will

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/234041.html
