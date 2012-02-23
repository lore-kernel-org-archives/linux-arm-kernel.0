From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 23 Feb 2012 18:16:59 +0200
Subject: [PATCH v2 2/2] iommu/omap: fix NULL pointer dereference
In-Reply-To: <20120223161109.GB2454@amd.com>
References: <1329902086-13868-1-git-send-email-ohad@wizery.com>
 <20120223161109.GB2454@amd.com>
Message-ID: <CAK=WgbYufgQY-O_MBcXc3aE23sx+r5ZQLS4h_bLUh6DKpLVqAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 6:11 PM, Joerg Roedel <Joerg.Roedel@amd.com> wrote:
> I guess these patches are 3.3 material?

Yes.

> How about tagging them for stable too?

Good point. But it's only relevant for this 2nd patch (the NULL
pointer dereference fix), as the first one is a 3.3 regression. Let me
know if you want me to resend the 2nd one with the stable tag.

Thanks,
Ohad.
