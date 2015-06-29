From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 29 Jun 2015 09:53:40 +0100
Subject: [PATCH] arm64: KVM: Enable minimalistic support for Thunder
In-Reply-To: <1435348284-32132-1-git-send-email-tchalamarla@caviumnetworks.com>
References: <1435348284-32132-1-git-send-email-tchalamarla@caviumnetworks.com>
Message-ID: <55910794.6000107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/06/15 20:51, Tirumalesh Chalamarla wrote:
> In order to allow KVM to run on Thunder implementations, add the
> minimal support required.
> 
> Signed-off-by: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>

CCing the KVM/ARM maintainers should be the first course of action.

Also, you may want to try Suzuki's patch instead:

http://www.spinics.net/lists/kvm/msg117703.html

Constantly adding new CPUs without providing any insight as to how they
should be emulated only brings churn, and not much benefit.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
