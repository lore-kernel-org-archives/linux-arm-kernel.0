From: cdall@linaro.org (Christoffer Dall)
Date: Thu, 2 Feb 2017 11:30:53 +0100
Subject: [RFC v3 07/10] KVM: arm/arm64: Set a background timer to the
 earliest timer expiration
In-Reply-To: <1485970990-13775-8-git-send-email-jintack@cs.columbia.edu>
References: <1485970990-13775-1-git-send-email-jintack@cs.columbia.edu>
 <1485970990-13775-8-git-send-email-jintack@cs.columbia.edu>
Message-ID: <20170202103053.GF27852@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 12:43:07PM -0500, Jintack Lim wrote:
> When scheduling a background timer, consider both of the virtual and
> physical timer and pick the earliest expiration time.
> 
> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
