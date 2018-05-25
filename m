From: olof@lixom.net (Olof Johansson)
Date: Fri, 25 May 2018 15:29:09 -0700
Subject: [PATCH 1/2] arm64: dts: Add GPIO and GPIO keys device nodes
In-Reply-To: <fcea1874b6e3d0243684c133c7b34f2384341a32.1523846102.git.baolin.wang@linaro.org>
References: <fcea1874b6e3d0243684c133c7b34f2384341a32.1523846102.git.baolin.wang@linaro.org>
Message-ID: <20180525222909.sedcwcakptjoetma@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 10:40:03AM +0800, Baolin Wang wrote:
> This patch adds device nodes to enable one GPIO controller located on
> digital chip, 2 EIC (external interrupt controller) controllers loacted
> on PMIC and digital chip for Spreadtrum SC9860 platform.
> 
> Moreover this patch adds 3 GPIO keys relied on EIC controller to support
> power key and volume up/down keys.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Applied with "sprd:" added to the subject.


-Olof
