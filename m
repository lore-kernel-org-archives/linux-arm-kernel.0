From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 Oct 2017 17:50:37 +0100
Subject: [PATCH v3 15/28] arm64: cpufeature: Move sys_caps_initialised
 declarations
In-Reply-To: <1507660725-7986-16-git-send-email-Dave.Martin@arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-16-git-send-email-Dave.Martin@arm.com>
Message-ID: <20171011165036.n4gl4k753zafgpbx@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 07:38:32PM +0100, Dave P Martin wrote:
> update_cpu_features() currently cannot tell whether it is being
> called during early or late secondary boot.  This doesn't
> desperately matter for anything it currently does.
> 
> However, SVE will need to know here whether the set of available
> vector lengths is fixed of still to be determined when booting a
> CPU so that it can be updated appropriately.
> 
> This patch simply moves the sys_caps_initialised stuff to the top
> of the file so that it can be more widely.  There doesn't seem to
> be a more obvious place to put it.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
