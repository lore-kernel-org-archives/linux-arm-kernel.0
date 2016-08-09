From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 9 Aug 2016 16:43:51 +0200
Subject: [PATCH v3] KVM: arm64: ITS: return 1 on successful MSI injection
In-Reply-To: <20160808162928.26441-1-andre.przywara@arm.com>
References: <20160808162928.26441-1-andre.przywara@arm.com>
Message-ID: <20160809144351.GH9175@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 08, 2016 at 05:29:28PM +0100, Andre Przywara wrote:
> According to the KVM API documentation a successful MSI injection
> should return a value > 0 on success.
> Return possible errors in vgic_its_trigger_msi() and report a
> successful injection back to userland, while also reporting the
> case where the MSI could not be delivered due to the guest not
> having the LPI mapped, for instance.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Applied.  Thanks!

-Christoffer
