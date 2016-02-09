From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 9 Feb 2016 19:45:17 +0100
Subject: [PATCH v2 23/28] ARM: KVM: Remove __weak attributes
In-Reply-To: <1454583645-10144-24-git-send-email-marc.zyngier@arm.com>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
 <1454583645-10144-24-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160209184517.GY5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 11:00:40AM +0000, Marc Zyngier wrote:
> Now that the old code is long gone, we can remove all the weak
> attributes, as there is only one version of the code.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
