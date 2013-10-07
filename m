From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 7 Oct 2013 07:29:29 -0300
Subject: [alsa-devel] [PATCH 1/2] ASoC: fsl: imx-ssi: fix probe on imx31
In-Reply-To: <525279CC.8080309@epfl.ch>
References: <1380630971-11431-1-git-send-email-philippe.retornaz@epfl.ch>
 <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
 <20131003155954.GV27287@sirena.org.uk> <524D963F.5080507@epfl.ch>
 <CAOMZO5C_kjTJ8iVGc67pcLLaO43arTiyMRQ1822VkBLDm7hzPw@mail.gmail.com>
 <525279CC.8080309@epfl.ch>
Message-ID: <CAOMZO5B8uHE1F2AKt9QA_b=9gbDb-RDQshk17nJs-q68r_6iKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 7, 2013 at 6:07 AM, Philippe R?tornaz
<philippe.retornaz@epfl.ch> wrote:

> Well, I don't think it's fair to break boards just because they are not
> (yet) converted to DT ... this board was merged before the DT era on ARM.

Sure, I agree. Just trying to avoid to keep two drivers for the same hardware.

I will try to convert mx31 to use sound/soc/fsl/fsl_ssi.c when time allows.

Regards,

Fabio Estevam
