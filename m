From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 11 Sep 2012 15:30:54 +0300
Subject: [PATCH] omap: remoteproc: set bootaddr support
In-Reply-To: <1345044348-19898-1-git-send-email-jgutierrez@ti.com>
References: <1345044348-19898-1-git-send-email-jgutierrez@ti.com>
Message-ID: <CAK=Wgbb6EKS1YqR89y08stkwz3zFw786J3an2iDT+rKFWyo+5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Juan,

On Wed, Aug 15, 2012 at 6:25 PM, Juan Gutierrez <jgutierrez@ti.com> wrote:
> Some remote processors (like Omap4's DSP) need to explicitly
> set a boot address from which they start executing code when
> taken out of reset.
>
> Support for this has been added to remoteproc code through
> a set_bootaddr function in the platform data which, if needed,
> must be set according to the backend rproc.
>
> For omap4's dsp we can use the next control funtion:
>
>   .set_bootaddr  = omap_ctrl_write_dsp_boot_addr
>
> Signed-off-by: Juan Gutierrez <jgutierrez@ti.com>

Applied with slight changes to the commit log. Thanks!

Ohad.
