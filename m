From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 4 Jul 2012 13:02:18 -0600 (MDT)
Subject: [PATCHv2 02/12] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
In-Reply-To: <4FF472C9.6000107@ti.com>
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004555.20034.87035.stgit@dusk> <4FDA15AA.6090704@ti.com>
 <alpine.DEB.2.00.1206141136080.30212@utopia.booyaka.com>
 <4FDA45F5.9090300@ti.com>
 <alpine.DEB.2.00.1206141706420.25628@utopia.booyaka.com>
 <4FDB387C.7030003@ti.com>
 <alpine.DEB.2.00.1207040625090.6760@utopia.booyaka.com>
 <alpine.DEB.2.00.1207040652240.6760@utopia.booyaka.com>
 <87mx3f38lh.fsf@ti.com> <4FF46BF5.50308@ti.com>
 <1341420070.2059.185.camel@sokoban> <4FF472C9.6000107@ti.com>
Message-ID: <alpine.DEB.2.00.1207041259400.6760@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Jul 2012, Benoit Cousson wrote:

> On 07/04/2012 06:41 PM, Tero Kristo wrote:
> > On Wed, 2012-07-04 at 18:14 +0200, Benoit Cousson wrote:
> >>
> >> On OMAP4 as well? I've just tried with the hwmod fix for AESS and USB
> >> and still cannot reach RET.
> >>
> >> Am I missing some other patches for OMAP4?
> > 
> > You need also fixes for sl2if and mcpdm in addition to above.
> 
> Are they in some lo branch already?

The old version of these patches are in the 'sl2if_mcpdm_reset_fix_3.5rc` 
branch of git://git.pwsan.com/linux-2.6 - they haven't yet been updated 
and tested per Beno?t's comments.  If someone else wants to take that over 
for 3.5-rc, by all means please do.


- Paul
