From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Oct 2017 12:00:08 +0100
Subject: [PATCH v4 04/13] arm64: alternatives: use tpidr_el2 on VHE hosts
In-Reply-To: <20171017174432.1684-5-james.morse@arm.com>
References: <20171017174432.1684-1-james.morse@arm.com>
 <20171017174432.1684-5-james.morse@arm.com>
Message-ID: <20171018110008.pr64c2osf4p4xv3f@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 06:44:23PM +0100, James Morse wrote:
> Now that KVM uses tpidr_el2 in the same way as Linux's cpu_offset in
> tpidr_el1, merge the two. This saves KVM from save/restoring tpidr_el1
> on VHE hosts, and allows future code to blindly access per-cpu variables
> without triggering world-switch.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Christoffer Dall <cdall@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
