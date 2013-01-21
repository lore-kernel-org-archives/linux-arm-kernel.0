From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Mon, 21 Jan 2013 05:27:16 +0000
Subject: [PATCH 0/9] ARM: OMAP2+: AM33XX: Misc fixes/updates
In-Reply-To: <1358493569-17142-1-git-send-email-vaibhav.bedia@ti.com>
References: <1358493569-17142-1-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECF09E0@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul, Benoit,

On Fri, Jan 18, 2013 at 12:49:20, Bedia, Vaibhav wrote:
> Hi,
> 
> The following patches were earlier posted as part the AM33XX
> suspend-resume support series [1]. Based on the suggestion
> from Santosh Shilimkar <santosh.shilimkar@ti.com> i have split
> out the changes which update the various data files related
> to AM33XX support.
> 
> These patches apply on top of v3.8-rc3
> 
> Regards,
> Vaibhav
> 
> [1] http://marc.info/?l=linux-arm-kernel&m=135698501821074&w=2
> 
> Vaibhav Bedia (9):
>   ARM: OMAP2+: AM33XX: CM: Get rid of unncessary header inclusions
>   ARM: OMAP2+: AM33XX: CM/PRM: Use __ASSEMBLER__ macros in header files
>   ARM: OMAP2+: AM33XX: hwmod: Register OCMC RAM hwmod
>   ARM: OMAP2+: AM33XX: hwmod: Update TPTC0 hwmod with the right flags
>   ARM: OMAP2+: AM33XX: hwmod: Fixup cpgmac0 hwmod entry
>   ARM: OMAP2+: AM33XX: hwmod: Update the WKUP-M3 hwmod with reset
>     status bit
>   ARM: OMAP2+: AM33XX: Update the hardreset API
>   ARM: DTS: AM33XX: Add nodes for OCMC RAM and WKUP-M3
>   ARM: OMAP2+: AM33XX: control: Add some control module registers and
>     APIs
> 

Any comments on these before I resend addressing the comments from Sergei?

Regards,
Vaibhav
