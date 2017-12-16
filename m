From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 15 Dec 2017 21:12:50 -0800
Subject: [PATCH v2 04/10] arm64: dts: qcom: msm8916: drop unused
 board-specific nodes
In-Reply-To: <20171207151942.5805-5-damien.riegel@savoirfairelinux.com>
References: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
 <20171207151942.5805-5-damien.riegel@savoirfairelinux.com>
Message-ID: <20171216051250.GA4281@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 07 Dec 07:19 PST 2017, Damien Riegel wrote:

> These nodes reserve and configure some pins as GPIOs. They are not
> generic pinctrls, they actually belong to board files but they are not
> used by any other node, so just drop them altogether.
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Let's introduce them back into the db410c when we define a client.

Regards,
Bjorn
