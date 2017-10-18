From: robh@kernel.org (Rob Herring)
Date: Wed, 18 Oct 2017 08:21:23 -0500
Subject: [PATCH v6 5/5] arm: dts: stm32: remove useless clocksource nodes
In-Reply-To: <1508331506-23782-6-git-send-email-benjamin.gaignard@linaro.org>
References: <1508331506-23782-1-git-send-email-benjamin.gaignard@linaro.org>
 <1508331506-23782-6-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <CABGGisx1mrf8xSWAXSm9sevE16HgCT72RhcpH6J44ECQnCd3Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 7:58 AM, Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
> 16 bits timers aren't accurate enough to be used as
> clocksource, remove them from stm32f4 and stm32f7 devicetree.

They aren't useful for anything? Zephyr? u-boot?

Rob
