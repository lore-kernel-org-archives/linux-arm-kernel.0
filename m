From: davidb@codeaurora.org (David Brown)
Date: Mon, 23 Apr 2012 16:09:49 -0700
Subject: [PATCH] ARM: msm: Fix gic irqdomain support
In-Reply-To: <CACxGe6sPkW8WviMX=oJEj+-G7XMeaWaQYfe_hg2quB-Sh2gEDA@mail.gmail.com>
References: <1335221222-30879-1-git-send-email-davidb@codeaurora.org>
 <CACxGe6sPkW8WviMX=oJEj+-G7XMeaWaQYfe_hg2quB-Sh2gEDA@mail.gmail.com>
Message-ID: <20120423230949.GA31173@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 04:55:11PM -0600, Grant Likely wrote:
> On Mon, Apr 23, 2012 at 4:47 PM, David Brown <davidb@codeaurora.org> wrote:
> > As of
> >
> > ? ?commit 75294957be1dee7d22dd7d90bd31334ba410e836
> > ? ?Author: Grant Likely <grant.likely@secretlab.ca>
> > ? ?Date: ? Tue Feb 14 14:06:57 2012 -0700
> >
> > ? ? ? ?irq_domain: Remove 'new' irq_domain in favour of the ppc one
> >
> > the ARM gic controller uses proper irq domains. ?Fix the MSM gic
> > initialization and DT so that it works again.
> >
> > Signed-off-by: David Brown <davidb@codeaurora.org>
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> This should go via the arm-soc tree I think

I was planning on going that route.

Thanks

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
