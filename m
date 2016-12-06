From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 6 Dec 2016 15:34:32 +0000
Subject: [PATCH v2] arm/arm64: xen: Move shared architecture headers to
 include/xen/arm
In-Reply-To: <1481038065-32153-3-git-send-email-marc.zyngier@arm.com>
References: <1481038065-32153-1-git-send-email-marc.zyngier@arm.com>
 <1481038065-32153-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <d39f3c15-e406-6c4c-b561-ce3e76ed67d8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/16 15:27, Marc Zyngier wrote:
> ARM and arm64 Xen ports share a number of headers, leading to
> packaging issues when these headers needs to be exported, as it
> breaks the reasonable requirement that an architecture port
> has self-contained headers.
> 
> Fix the issue by moving the 5 header files to include/xen/arm,
> and keep local placeholders to include the relevant files.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> * From v1:
>   - Move offending include files to include/xen/arm

Duh. Apologies for the spurious resend, I messed up.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
