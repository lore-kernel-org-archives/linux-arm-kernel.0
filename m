From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 2 Feb 2018 17:48:41 +0000
Subject: [PATCH 1/2] arm64: entry: Apply BP hardening for high-priority
 synchronous exceptions
In-Reply-To: <1517592700-26497-2-git-send-email-will.deacon@arm.com>
References: <1517592700-26497-1-git-send-email-will.deacon@arm.com>
 <1517592700-26497-2-git-send-email-will.deacon@arm.com>
Message-ID: <3f4e2a58-51be-91c6-04da-368bcc47f32f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/18 17:31, Will Deacon wrote:
> Software-step and PC alignment fault exceptions have higher priority than
> instruction abort exceptions, so apply the BP hardening hooks there too
> if the user PC appears to reside in kernel space.
> 
> Reported-by: Dan Hettena <dhettena@nvidia.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
