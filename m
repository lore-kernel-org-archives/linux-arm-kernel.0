From: timur@tabi.org (Timur Tabi)
Date: Wed, 13 Mar 2013 17:55:24 -0500
Subject: [PATCH 01/10] imx-ssi: Fix AC97 rates
In-Reply-To: <20130311195108.GC18350@pengutronix.de>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-2-git-send-email-mpa@pengutronix.de>
 <CAOMZO5A8F81PzCjKHrkZ_AtGMr341d6OmYHMQvdzgunmGFDVsw@mail.gmail.com>
 <20130311195108.GC18350@pengutronix.de>
Message-ID: <CAOZdJXXm=jJv3zyD4j11t3BgNGyKz6V9jzShQLTk-BTiwDjvMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 11, 2013 at 2:51 PM, Markus Pargmann <mpa@pengutronix.de> wrote:
>
> At the moment fsl-ssi and imx-ssi don't seem to have very much in
> common. However I could try to merge the imx-ssi driver code into
> fsl_ssi and make it handle imx27-ssi differently.

imx-ssi is the legacy driver that supports older, non-DT IMX platforms.
fsl-ssi is the "new" driver that supports PowerPC and IMX DT-enabled platforms.

-- 
Timur Tabi
Linux kernel developer at Freescale
