From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 8 Sep 2014 15:04:15 +0100
Subject: [PATCH v10] arm64: Add architectural support for PCIe
In-Reply-To: <20140908140129.GE22717@arm.com>
References: <1410184549-17690-1-git-send-email-Liviu.Dudau@arm.com>
 <1410184549-17690-2-git-send-email-Liviu.Dudau@arm.com>
 <20140908140129.GE22717@arm.com>
Message-ID: <20140908140415.GL27864@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 03:01:30PM +0100, Catalin Marinas wrote:
> On Mon, Sep 08, 2014 at 02:55:49PM +0100, Liviu Dudau wrote:
> > Use the generic PCI domain and OF functions
> > to provide support for PCI Express on arm64.
> > 
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > [Generic PCI domain support]
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Minor detail: when have I signed this patch off? I'm not the author
> (maybe bits of it but I think most of it is yours). However, you can
> add:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I've took the patch from here: https://lkml.org/lkml/2014/7/14/529

It does have your Signed-off-by, all I did was split it up into the
relevant chunks.

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
