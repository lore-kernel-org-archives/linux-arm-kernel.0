From: cdall@linaro.org (Christoffer Dall)
Date: Thu, 2 Feb 2017 11:04:23 +0100
Subject: [RFC v3 03/10] KVM: arm/arm64: Decouple kvm timer functions from
 virtual timer
In-Reply-To: <1485970990-13775-4-git-send-email-jintack@cs.columbia.edu>
References: <1485970990-13775-1-git-send-email-jintack@cs.columbia.edu>
 <1485970990-13775-4-git-send-email-jintack@cs.columbia.edu>
Message-ID: <20170202100423.GB27852@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 12:43:03PM -0500, Jintack Lim wrote:
> Now that we have a separate structure for timer context, make functions
> generic so that they can work with any timer context, not just the
> virtual timer context.  This does not change the virtual timer
> functionality.
> 
> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
