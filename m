From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 11 Jan 2015 15:03:27 +0100
Subject: [PATCH RESEND v15 10/10] KVM: arm/arm64: Enable Dirty Page
 logging for ARMv8
In-Reply-To: <1420767727-20851-2-git-send-email-m.smarduch@samsung.com>
References: <1420767727-20851-1-git-send-email-m.smarduch@samsung.com>
 <1420767727-20851-2-git-send-email-m.smarduch@samsung.com>
Message-ID: <20150111140327.GY21092@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 05:42:07PM -0800, Mario Smarduch wrote:
> This patch enables ARMv8 dirty page logging support. Plugs ARMv8 into generic
> layer through Kconfig symbol, and drops earlier ARM64 constraints to enable
> logging at architecture layer. I applies cleanly on top patches series
> posted Dec 15:
> https://lists.cs.columbia.edu/pipermail/kvmarm/2014-December/012826.html
> 
> Patch number #11 of the series has be dropped.

Again, the stuff about where this applied and other information related
to the series should go below the '---' markers.

I suggest we iterate on patch 07 and make sure we agree, and then you
send out a complete new series (collect the acks and reviewed-by's in
there please), so I know I'll end up picking the right patches, as this
whole series has sort of sprawled.

> 
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>

Otherwise:

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

Thanks,
-Christoffer
