From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 30 Jul 2018 12:26:07 +0200
Subject: [PATCH 0/9] Add Reset Controller support for Actions Semi Owl SoCs
In-Reply-To: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
Message-ID: <c3ae668a-6bcc-a0eb-1e00-14ef9d607316@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mani,

Am 27.07.2018 um 20:45 schrieb Manivannan Sadhasivam:
> This patchset adds Reset Controller (RMU) support for Actions Semi
> Owl SoCs, S900 and S700. For the Owl SoCs, RMU has been integrated into
> the clock subsystem in hardware. Hence, in software we integrate RMU
> support into common clock driver inorder to maintain compatibility.

Can this not be placed into drivers/reset/ by using mfd-simple with a
sub-node in DT?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
