From: cdall@linaro.org (Christoffer Dall)
Date: Thu, 2 Feb 2017 11:03:39 +0100
Subject: [RFC v3 02/10] KVM: arm/arm64: Move cntvoff to each timer context
In-Reply-To: <1485970990-13775-3-git-send-email-jintack@cs.columbia.edu>
References: <1485970990-13775-1-git-send-email-jintack@cs.columbia.edu>
 <1485970990-13775-3-git-send-email-jintack@cs.columbia.edu>
Message-ID: <20170202100339.GA27852@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 12:43:02PM -0500, Jintack Lim wrote:
> Make cntvoff per each timer context. This is helpful to abstract kvm
> timer functions to work with timer context without considering timer
> types (e.g. physical timer or virtual timer).
> 
> This also would pave the way for ever doing adjustments of the cntvoff
> on a per-CPU basis if that should ever make sense.
> 
> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
