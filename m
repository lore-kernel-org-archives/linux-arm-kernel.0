From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 18 May 2016 16:14:08 +0200
Subject: [PATCH v4 36/56] KVM: arm/arm64: vgic-new: Add GICv3 IDREGS
 register handler
In-Reply-To: <1463392481-26583-37-git-send-email-andre.przywara@arm.com>
References: <1463392481-26583-1-git-send-email-andre.przywara@arm.com>
 <1463392481-26583-37-git-send-email-andre.przywara@arm.com>
Message-ID: <CAMJs5B8KZv=dGDYtrXo3FQ9sx2=G+rrTFgN10tLLfb4O+wBcGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 10:53:24AM +0100, Andre Przywara wrote:
> We implement the only one ID register that is required by the
> architecture, also this is the one that Linux actually checks.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
