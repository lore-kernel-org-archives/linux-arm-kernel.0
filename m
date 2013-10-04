From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 4 Oct 2013 15:10:00 -0300
Subject: [alsa-devel] [PATCH 1/2] ASoC: fsl: imx-ssi: fix probe on imx31
In-Reply-To: <524D963F.5080507@epfl.ch>
References: <1380630971-11431-1-git-send-email-philippe.retornaz@epfl.ch>
 <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
 <20131003155954.GV27287@sirena.org.uk> <524D963F.5080507@epfl.ch>
Message-ID: <CAOMZO5C_kjTJ8iVGc67pcLLaO43arTiyMRQ1822VkBLDm7hzPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

On Thu, Oct 3, 2013 at 1:07 PM, Philippe R?tornaz
<philippe.retornaz@epfl.ch> wrote:

> It was working but it is broken since a few release.
> There is no need to rush for a fix, both patches can follow the standard
> process.

Thanks for the fix.

If you have a chance, it would be really nice if mx31-moboard could be
converted to device tree, as this would help us towards the goal of
getting rid of the sound/soc/fsl/imx-ssi.c driver, which only supports
the non-dt imx parts.

We have been using  sound/soc/fsl/fsl_ssi.c for the dt imx and powerpc
parts, and that's probably the reason we haven't noticed this bug.

Regards,

Fabio Estevam
