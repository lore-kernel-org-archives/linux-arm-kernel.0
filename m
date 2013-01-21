From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Mon, 21 Jan 2013 10:37:06 +0000
Subject: [PATCH 0/9] ARM: OMAP2+: AM33XX: Misc fixes/updates
In-Reply-To: <87zk02aox3.fsf@dell.be.48ers.dk>
References: <1358493569-17142-1-git-send-email-vaibhav.bedia@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433ECF09E0@DBDE01.ent.ti.com>
 <87zk02aox3.fsf@dell.be.48ers.dk>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECF1189@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Mon, Jan 21, 2013 at 14:33:20, Peter Korsgaard wrote:
> >>>>> "V" == Bedia, Vaibhav <vaibhav.bedia@ti.com> writes:
> 
> Hi,
> 
>  >> Vaibhav Bedia (9):
>  >> ARM: OMAP2+: AM33XX: CM: Get rid of unncessary header inclusions
>  >> ARM: OMAP2+: AM33XX: CM/PRM: Use __ASSEMBLER__ macros in header files
>  >> ARM: OMAP2+: AM33XX: hwmod: Register OCMC RAM hwmod
>  >> ARM: OMAP2+: AM33XX: hwmod: Update TPTC0 hwmod with the right flags
>  >> ARM: OMAP2+: AM33XX: hwmod: Fixup cpgmac0 hwmod entry
>  >> ARM: OMAP2+: AM33XX: hwmod: Update the WKUP-M3 hwmod with reset
>  >> status bit
>  >> ARM: OMAP2+: AM33XX: Update the hardreset API
>  >> ARM: DTS: AM33XX: Add nodes for OCMC RAM and WKUP-M3
>  >> ARM: OMAP2+: AM33XX: control: Add some control module registers and
>  >> APIs
>  >> 
> 
>  V> Any comments on these before I resend addressing the comments from Sergei?
> 
> Wouldn't the ocmram/wkup dt nodes need a reg property to define their
> size as I indirectly mentioned here:
> 
> http://thread.gmane.org/gmane.linux.ports.arm.omap/91405/focus=92061
> 

My apologies. I missed your comment on that patch and just responded to it.
Will add the reg property for the DT nodes in the next version.

Regards,
Vaibhav
