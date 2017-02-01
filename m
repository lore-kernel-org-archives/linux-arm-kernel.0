From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 1 Feb 2017 15:44:30 +0000
Subject: [PATCH v2 2/3] arm64: kvm: reuse existing cache type/info related
 macros
In-Reply-To: <1485793527-18028-2-git-send-email-sudeep.holla@arm.com>
References: <1485793527-18028-1-git-send-email-sudeep.holla@arm.com>
 <1485793527-18028-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <d5d85965-8bee-3ba0-7a0c-a4727f5fe9f8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/01/17 16:25, Sudeep Holla wrote:
> We already have various macros related to cache type and bitfields in
> CLIDR system register. We can replace some of the hardcoded values
> here using those existing macros.
> 
> This patch reuses those existing cache type/info related macros and
> replaces the hardcorded values. It also removes some of the comments
> that become trivial with the macro names.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
