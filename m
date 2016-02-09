From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 9 Feb 2016 19:45:22 +0100
Subject: [PATCH v2 24/28] ARM: KVM: Turn CP15 defines to an enum
In-Reply-To: <1454583645-10144-25-git-send-email-marc.zyngier@arm.com>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
 <1454583645-10144-25-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160209184522.GZ5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 11:00:41AM +0000, Marc Zyngier wrote:
> Just like on arm64, having the CP15 registers expressed as a set
> of #defines has been very conflict-prone. Let's turn it into an
> enum, which should make it more manageable.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
