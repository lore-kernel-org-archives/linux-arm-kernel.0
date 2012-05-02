From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Wed, 2 May 2012 05:42:34 +0000
Subject: [PATCH 0/2] OMAP: mailbox initial device tree support
In-Reply-To: <1335894460-19941-1-git-send-email-omar.luna@linaro.org>
References: <1335894460-19941-1-git-send-email-omar.luna@linaro.org>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EA68F6D@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Omar,

On Tue, May 01, 2012 at 23:17:38, Omar Ramirez Luna wrote:
> To allow mailbox driver to function with device tree.
> 
> Tested in OMAP4 and OMAP3. OMAP2 untested.
>

I think the mailbox code needs a cleanup similar to what you
had proposed earlier [1] before the device tree support is added.

We probably need to decide whether the number of mailbox sub-modules
should be part of hwmod attribute or come from device tree. IMO the
static allocation of the mailboxes is better suited in the device-tree
data.

Regards,
Vaibhav

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/054582.html
