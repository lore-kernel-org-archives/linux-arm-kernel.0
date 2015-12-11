From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 11 Dec 2015 13:24:53 -0600
Subject: [PATCH 1/4] ARM: dts: qcom: apq8064-ifc6410 Use hardware flow
 control for GSBI6
In-Reply-To: <1449858598-13429-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1449858409-13296-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1449858598-13429-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20151211192453.GB4022@Agamemnon.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 06:29:58PM +0000, Srinivas Kandagatla wrote:
> From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
> 
> GSBI6 UART module is connected to BT chip, which uses
> hardware flow control lines. Enable them on SoC side.
> 
> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>

Looks fine to me. Thanks for the patch.
