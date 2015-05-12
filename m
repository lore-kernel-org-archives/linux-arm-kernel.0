From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 12 May 2015 16:07:41 +0200
Subject: [PATCH 01/12] arm/arm64: kvm: add missing PSCI include
In-Reply-To: <1431085004-32743-2-git-send-email-mark.rutland@arm.com>
References: <1431085004-32743-1-git-send-email-mark.rutland@arm.com>
 <1431085004-32743-2-git-send-email-mark.rutland@arm.com>
Message-ID: <20150512140741.GH32765@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 12:36:33PM +0100, Mark Rutland wrote:
> We make use of the PSCI function IDs, but don't explicitly include the
> header which defines them. Relying on transitive header includes is
> fragile and will be broken as headers are refactored.
> 
> This patch includes the relevant header file directly so as to avoid
> future breakage.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
