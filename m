From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 6 Sep 2016 12:53:49 +0200
Subject: [PATCH v2 3/7] arm: KVM: Use common AArch32 conditional
 execution code
In-Reply-To: <1473150527-4729-4-git-send-email-marc.zyngier@arm.com>
References: <1473150527-4729-1-git-send-email-marc.zyngier@arm.com>
 <1473150527-4729-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160906105349.GM30513@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 09:28:43AM +0100, Marc Zyngier wrote:
> Add the bit of glue and const-ification that is required to use
> the code inherited from the arm64 port, and move over to it.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
