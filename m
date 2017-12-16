From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 15 Dec 2017 21:18:33 -0800
Subject: [PATCH v2 06/10] arm64: dts: qcom: msm8916: move pinconfs to
 board files
In-Reply-To: <20171207151942.5805-7-damien.riegel@savoirfairelinux.com>
References: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
 <20171207151942.5805-7-damien.riegel@savoirfairelinux.com>
Message-ID: <20171216051833.GC4281@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 07 Dec 07:19 PST 2017, Damien Riegel wrote:

> Following a suggestion from Bjorn Andersson [1], this commit moves
> electrical specifications which were defined in mms8916-pins.dtsi to
> board files, where they actually belong.
> 
> Pinmuxing is kept in the platform file because there are no alternative
> pins on which all these functions could be routed, so this part is
> indeed common to all boards using this SoC.
> 
> [1] https://www.spinics.net/lists/devicetree/msg201764.html
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

I like the move, but I would prefer that you mimic the base structure,
rather than just appending properties based on labels.

Regards,
Bjorn
