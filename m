From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Thu, 14 Feb 2013 14:15:19 +0200
Subject: [PATCH v8 0/8] Add tested id switch and vbus connect detect
 support for Chipidea
In-Reply-To: <1360051215-27722-1-git-send-email-peter.chen@freescale.com>
References: <1360051215-27722-1-git-send-email-peter.chen@freescale.com>
Message-ID: <871ucjay7c.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Chen <peter.chen@freescale.com> writes:

> Changes for v7:
> - Add ci_supports_gadget helper to know if the controller
> supports gadget, if the controller supports gadget, it
> needs to read otgsc to know the vbus value, basically,
> if the controller supports gadget, it will support host
> as well [3/8]
> - At ci_hdrc_probe, it needs to add free memory at error path
> [3/8]
> - Cosolidate ci->driver = NULL at ci13xxx_stop
> [8/8]

Michael, Marc, could you give your Tested-by's and/or Reviewed-by's for
this one?

Thanks,
--
Alex
