From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 30 Mar 2015 11:29:08 +0100
Subject: [PATCH v2 1/8] mmc: sdhci-st: Add macros for register offsets
 and bitfields for mmcss glue regs
In-Reply-To: <54F58BED.4020900@st.com>
References: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org>
 <1424956227-18258-2-git-send-email-peter.griffin@linaro.org>
 <54F58BED.4020900@st.com>
Message-ID: <20150330102908.GA21893@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Tue, 03 Mar 2015, Maxime Coquelin wrote:

> >+
> >+#define	ST_MMC_CCONFIG_REG_1		0x400
> Maybe my mail client, but I see a tab instead of a space after #define.

Yes your correct, have fixed all occurances in v3

regards,

Peter.
