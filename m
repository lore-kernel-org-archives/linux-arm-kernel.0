From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 9 Oct 2012 04:41:12 +0000 (UTC)
Subject: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain
 transitioning to OFF when in-use
In-Reply-To: <5073528F.2020902@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
 <1339104132-26885-9-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com>
 <500028B3.1040309@ti.com>
 <alpine.DEB.2.00.1207131418500.25585@utopia.booyaka.com>
 <50045D17.9050704@ti.com>
 <alpine.DEB.2.00.1207161228470.28834@utopia.booyaka.com>
 <50171841.40309@ti.com> <501760BF.8070801@ti.com> <5018210A.1040902@ti.com>
 <50187644.40308@ti.com>
 <alpine.DEB.2.00.1208010932270.21488@utopia.booyaka.com>
 <5073528F.2020902@ti.com>
Message-ID: <alpine.DEB.2.00.1210090440290.5736@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Mon, 8 Oct 2012, Jon Hunter wrote:

> I was looking at what got merged and it appears that the above code was
> added to the omap2 clkdm enable/disable functions and not omap3. I believe
> that is a mistake? If so the below fixes this.

Yep looks like either a mismerge or a victim of a rebase -- queued for 
late 3.7 fixes -- thanks,

- Paul
