From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 15 Dec 2017 21:20:39 -0800
Subject: [PATCH v2 09/10] arm64: dts: qcom: msm8916: normalize I2C and
 SPI nodes
In-Reply-To: <20171207151942.5805-10-damien.riegel@savoirfairelinux.com>
References: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
 <20171207151942.5805-10-damien.riegel@savoirfairelinux.com>
Message-ID: <20171216052039.GF4281@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 07 Dec 07:19 PST 2017, Damien Riegel wrote:

> The QUP core can be used either for I2C or SPI, so the same IP is mapped
> by a driver or the other. SPI bindings use a leading 0 for the start
> address and a size of 0x600, I2C bindings don't have the leading 0 and
> have a size 0x1000.
> 
> To make them more similar, add the leading 0 to I2C bindings and changes
> the size to 0x500 for all of them, as this is the actual size of these
> blocks. Also align the second entry of the clocks array.
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
