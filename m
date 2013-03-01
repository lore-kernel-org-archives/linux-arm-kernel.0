From: olof@lixom.net (Olof Johansson)
Date: Thu, 28 Feb 2013 17:24:21 -0800
Subject: [PATCH v2 0/3] Get rid of big array from imx pinctrl driver
In-Reply-To: <1361533888-18073-1-git-send-email-shawn.guo@linaro.org>
References: <1361533888-18073-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAOesGMjAzSt948+sKRNRzQ3T3F4fbvzBcXYXKmkwW_AAdmiMng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 22, 2013 at 3:51 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Changes since v1:
>  * Remove the absolute path of imxXX-pinfunc.h in binding doc
>  * Remove the pin id from PIN_FUNC_ID/macro
>
> Shawn Guo (3):
>   ARM: dts: imx: use pre-processor for device trees
>   ARM: dts: imx: replace magic number with pin function name
>   pinctrl: imx: move hard-coding data into device tree

These patches were too large to make it out on any mailing list. I'm
guessing only the people who were recipients of them saw them.

Please figure out a way to post your work in a way that it can be reviewed.



-Olof
