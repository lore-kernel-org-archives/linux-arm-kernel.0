From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Jun 2013 11:03:41 +0200
Subject: [PATCH 4/5] ARM: ux500: Provide auxdata to ux500 ASoC driver
In-Reply-To: <1369920465-13905-5-git-send-email-fabio.baltieri@linaro.org>
References: <1369920465-13905-1-git-send-email-fabio.baltieri@linaro.org>
 <1369920465-13905-5-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <CACRpkda8h_zewd2M7QzvoLn15iDEUv8XYCGqro62chiCcYaM8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 3:27 PM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:

> Ux500 ASoC driver is expected to have a specific device name to get
> clock resources correctly.  This patch provides the necessary
> OF_DEV_AUXDATA to match the name in DT and non-DT cases.
>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>

Patch applied to my ux500-devicetree branch after some rebasing.

Yours,
Linus Walleij
