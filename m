From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jan 2016 15:00:30 +0100
Subject: [PATCH 2/5] arm64: dts: apq8016-sbc: move sdhci node under soc
 node
In-Reply-To: <1452606412-24659-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1452606358-24569-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1452606412-24659-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <18094818.3Fy0P66y0u@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 January 2016 13:46:52 Srinivas Kandagatla wrote:
> To be consistent with other nodes move sdhci node under the soc node,
> rather than using lable references.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 

Maybe remove the label as well if you are no longer using it?

	Arnd
