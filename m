From: cdall@linaro.org (Christoffer Dall)
Date: Thu, 23 Feb 2017 16:57:07 +0100
Subject: [PATCH v2 2/3] arm64: kvm: reuse existing cache type/info
 related macros
In-Reply-To: <1485793527-18028-2-git-send-email-sudeep.holla@arm.com>
References: <1485793527-18028-1-git-send-email-sudeep.holla@arm.com>
 <1485793527-18028-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <20170223155707.GD1409@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 04:25:26PM +0000, Sudeep Holla wrote:
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

Acked-by: Christoffer Dall <cdall@linaro.org>
