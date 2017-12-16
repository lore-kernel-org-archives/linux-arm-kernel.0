From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 15 Dec 2017 21:19:36 -0800
Subject: [PATCH v2 08/10] arm64: dts: qcom: msm8916-pins: move sdhc2 cd
 node with its siblings
In-Reply-To: <20171207151942.5805-9-damien.riegel@savoirfairelinux.com>
References: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
 <20171207151942.5805-9-damien.riegel@savoirfairelinux.com>
Message-ID: <20171216051936.GE4281@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 07 Dec 07:19 PST 2017, Damien Riegel wrote:

> Nodes relative to the first sdhc node were interlaced with node of the
> second sdhc. Move sdhc2_cd_pin with its siblings to prevent that. Also
> rename the grouping node from sdhc2_cd_pin to pmx_sdc2_cd_pin, as
> "pmx_sdc" is the prefix used by other nodes.
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
