From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 9 Apr 2013 12:03:37 +0300
Subject: [PATCH v9 4/6] ARM: davinci: Add a remoteproc driver
 implementation for OMAP-L13x DSP
In-Reply-To: <13514BD7FAEBA745BBD7D8A672905C14312302EA@DFLE12.ent.ti.com>
References: <1364521307-1219-1-git-send-email-rtivy@ti.com>
 <1364521307-1219-5-git-send-email-rtivy@ti.com>
 <CAK=WgbZme2UkMeP-JB2h3xnmcpzAaYeOcy7gxh60muJ8KZbr_A@mail.gmail.com>
 <13514BD7FAEBA745BBD7D8A672905C14312302EA@DFLE12.ent.ti.com>
Message-ID: <CAK=Wgba6_4T0Y1=xBpqw8fbxYhSDfWsj5XoLSAJAhq-MkxV9pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 9, 2013 at 1:02 AM, Tivy, Robert <rtivy@ti.com> wrote:
> The platform_get_irq()/irq_get_irq_data()/platform_get_resource() calls don't have "put" counterparts.  The "devm_*" calls get automatically cleaned up (and I wasn't able to find any existing example of some code that actually does the cleanup explicitly).

Fair enough, thanks for looking.

> Sergei had a comment to change devm_request_and_ioremap() to devm_ioremap_resource(), so I will submit a new patch with your and Sergei's comments applied.

Thanks!
