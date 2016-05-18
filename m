From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 18 May 2016 16:15:59 +0200
Subject: [PATCH v4 35/56] KVM: arm/arm64: vgic-new: Add GICv3
 redistributor IIDR and TYPER handler
In-Reply-To: <1463392481-26583-36-git-send-email-andre.przywara@arm.com>
References: <1463392481-26583-1-git-send-email-andre.przywara@arm.com>
 <1463392481-26583-36-git-send-email-andre.przywara@arm.com>
Message-ID: <20160518141559.GH6666@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 10:53:23AM +0100, Andre Przywara wrote:
> The redistributor TYPER tells the OS about the associated MPIDR,
> also the LAST bit is crucial to determine the number of redistributors.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
