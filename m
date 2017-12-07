From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Dec 2017 15:43:48 +0100
Subject: [PATCH] arm: dts: qcom: fix missing #phy-cells for apq8064
In-Reply-To: <20171109225422.14280-1-robh@kernel.org>
References: <20171109225422.14280-1-robh@kernel.org>
Message-ID: <CAK8P3a3wupYd7XiJrYsFafbmdpiw_zFVd42E8Ucm9oNXtwzWSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 9, 2017 at 11:54 PM, Rob Herring <robh@kernel.org> wrote:
> Fix dtc warnings for missing #phy-cells for apq8064:
>
> Warning (phys_property): Missing property '#phy-cells' in node /soc/dsi-phy at 4700200 or bad phandle (referred from /soc/mdss_dsi at 4700000:phys[0])
> Warning (phys_property): Missing property '#phy-cells' in node /soc/hdmi-phy at 4a00400 or bad phandle (referred from /soc/hdmi-tx at 4a00000:phys[0])
>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: linux-arm-msm at vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to fixes, thanks!

       Anrd
