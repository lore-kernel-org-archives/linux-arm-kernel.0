From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 9 Feb 2016 19:45:26 +0100
Subject: [PATCH v2 25/28] ARM: KVM: Cleanup asm-offsets.c
In-Reply-To: <1454583645-10144-26-git-send-email-marc.zyngier@arm.com>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
 <1454583645-10144-26-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160209184526.GA5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 11:00:42AM +0000, Marc Zyngier wrote:
> Since we don't have much assembler left, most of the KVM stuff
> in asm-offsets.c is now superfluous. Let's get rid of it.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
