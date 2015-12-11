From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 11 Dec 2015 22:20:03 +0100
Subject: [PATCH v3 06/22] arm64: KVM: Implement timer save/restore
In-Reply-To: <1449485618-9443-7-git-send-email-marc.zyngier@arm.com>
References: <1449485618-9443-1-git-send-email-marc.zyngier@arm.com>
 <1449485618-9443-7-git-send-email-marc.zyngier@arm.com>
Message-ID: <20151211212003.GH27689@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 10:53:22AM +0000, Marc Zyngier wrote:
> Implement the timer save restore as a direct translation of
> the assembly code version.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
