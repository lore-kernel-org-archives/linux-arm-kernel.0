From: lethal@linux-sh.org (Paul Mundt)
Date: Fri, 1 Feb 2013 23:09:28 +0900
Subject: [PATCH v6 0/4] Renesas IPMMU driver for sh7372, sh73a0 and r8a7740
In-Reply-To: <20130201135633.GH25591@8bytes.org>
References: <1358765669-14567-1-git-send-email-hdk@igel.co.jp>
 <20130201135633.GH25591@8bytes.org>
Message-ID: <20130201140927.GA12216@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 02:56:33PM +0100, Joerg Roedel wrote:
> On Mon, Jan 21, 2013 at 07:54:25PM +0900, Hideki EIRAKU wrote:
> > Hideki EIRAKU (4):
> >   iommu/shmobile: Add iommu driver for Renesas IPMMU modules
> >   ARM: mach-shmobile: sh7372: Add IPMMU device
> >   ARM: mach-shmobile: sh73a0: Add IPMMU device
> >   ARM: mach-shmobile: r8a7740: Add IPMMU device
> 
> Paul, Magnus, any opinions on patches 2-4? Can you ACK them when they
> are ok for you?
> 
No strong opinions one way or the other, patches 2-4 don't really do
anything of significance.

Acked-by: Paul Mundt <lethal@linux-sh.org>
