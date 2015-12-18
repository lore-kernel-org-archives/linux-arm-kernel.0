From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 18 Dec 2015 10:58:47 +0100
Subject: [PATCH v2] ARM: KVM: Cleanup exception injection
In-Reply-To: <1450349383-19975-1-git-send-email-marc.zyngier@arm.com>
References: <1450349383-19975-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20151218095847.GC32720@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 10:49:43AM +0000, Marc Zyngier wrote:
> David Binderman reported that the exception injection code had a
> couple of unused variables lingering around.
> 
> Upon examination, it looked like this code could do with an
> anticipated spring cleaning, which amounts to deduplicating
> the CPSR/SPSR update, and making it look a bit more like
> the architecture spec.
> 
> The spurious variables are removed in the process.
> 
> Reported-by: David Binderman <dcb314@hotmail.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
