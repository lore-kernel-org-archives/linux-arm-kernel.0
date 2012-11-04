From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Sun, 4 Nov 2012 15:26:19 +0000
Subject: [PATCH 09/15] ARM: OMAP: AM33XX: Remove unnecessary include and
 use __ASSEMBLER__ macros
In-Reply-To: <50954683.4050302@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-10-git-send-email-vaibhav.bedia@ti.com>
 <50954683.4050302@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFFD3C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 03, 2012 at 21:59:55, Shilimkar, Santosh wrote:
> On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> > Get rid of some unnecessary header file inclusions
> > and also use __ASSEMBLER__ macros to allow the
> > various register offsets from PM assembly code
> > which be added in a subsequent patch.
> >
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> 
> Ideally you should split header clean-up and assembler
> fix in seperate patches.
> 

Ok. Will do.

Regards,
Vaibhav
