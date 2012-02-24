From: Joerg.Roedel@amd.com (Joerg Roedel)
Date: Fri, 24 Feb 2012 14:16:38 +0100
Subject: [PATCH v2 2/2] iommu/omap: fix NULL pointer dereference
In-Reply-To: <CAK=WgbYufgQY-O_MBcXc3aE23sx+r5ZQLS4h_bLUh6DKpLVqAg@mail.gmail.com>
References: <1329902086-13868-1-git-send-email-ohad@wizery.com>
 <20120223161109.GB2454@amd.com>
 <CAK=WgbYufgQY-O_MBcXc3aE23sx+r5ZQLS4h_bLUh6DKpLVqAg@mail.gmail.com>
Message-ID: <20120224131638.GH2454@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 06:16:59PM +0200, Ohad Ben-Cohen wrote:
> On Thu, Feb 23, 2012 at 6:11 PM, Joerg Roedel <Joerg.Roedel@amd.com> wrote:
> > I guess these patches are 3.3 material?
> 
> Yes.
> 
> > How about tagging them for stable too?
> 
> Good point. But it's only relevant for this 2nd patch (the NULL
> pointer dereference fix), as the first one is a 3.3 regression. Let me
> know if you want me to resend the 2nd one with the stable tag.

Applied both and added stable-tag to the second patch. I'll send the
pull-request when you guys also send me the correct fix for the
outstanding initialization order issue on OMAP.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
