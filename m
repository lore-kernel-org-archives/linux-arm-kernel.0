From: cdall@linaro.org (Christoffer Dall)
Date: Thu, 2 Feb 2017 11:31:03 +0100
Subject: [RFC v3 09/10] KVM: arm64: Add the EL1 physical timer access
 handler
In-Reply-To: <1485970990-13775-10-git-send-email-jintack@cs.columbia.edu>
References: <1485970990-13775-1-git-send-email-jintack@cs.columbia.edu>
 <1485970990-13775-10-git-send-email-jintack@cs.columbia.edu>
Message-ID: <20170202103103.GH27852@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 12:43:09PM -0500, Jintack Lim wrote:
> KVM traps on the EL1 phys timer accesses from VMs, but it doesn't handle
> those traps. This results in terminating VMs. Instead, set a handler for
> the EL1 phys timer access, and inject an undefined exception as an
> intermediate step.
> 
> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
