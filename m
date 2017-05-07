From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 7 May 2017 09:45:53 +0200
Subject: [PATCH 1/5] pinctrl: qcom: Add ipq8074 pinctrl driver
In-Reply-To: <1493373403-23462-2-git-send-email-varada@codeaurora.org>
References: <1493373403-23462-1-git-send-email-varada@codeaurora.org>
 <1493373403-23462-2-git-send-email-varada@codeaurora.org>
Message-ID: <CACRpkdbvUBMMnY90gmAUMrUiEx3+gSdvm_oLPTLYej3vJivf1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 28, 2017 at 11:56 AM, Varadarajan Narayanan
<varada@codeaurora.org> wrote:

> Add initial pinctrl driver to support pin configuration with
> pinctrl framework for ipq8074.
>
> Signed-off-by: Manoharan Vijaya Raghavan <mraghava@codeaurora.org>
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>

Bjorn Andersson is the maintainer of the qcom pinctrl drivers so you need
to put him on the To: line so he can review and comment on the patches
for new qcom pin control drivers.

Bjorn maybe you should patch MAINTAINERS so you do not get missed...

Yours,
Linus Walleij
