From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Wed, 13 Feb 2013 10:56:50 +0000
Subject: [RFC v2 07/18] ARM: OMAP2+: AM33XX: hwmod: Update TPTC0 hwmod
 with the right flags
In-Reply-To: <87fw12xw70.fsf@linaro.org>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-8-git-send-email-vaibhav.bedia@ti.com>
 <87fw12xw70.fsf@linaro.org>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED1CDEA@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Tue, Feb 12, 2013 at 05:03:23, Kevin Hilman wrote:
> Vaibhav Bedia <vaibhav.bedia@ti.com> writes:
> 
> > TPTC0 needs to be idled and put to standby under SW control.
> 
> Please elaborate about why (e.g. HW support not available, HW support
> broken/buggy, etc.) since these blocks are not well documented in the
> docs that I have (spruh73f.)
> 

This change was picked up for v3.9. I'll submit a follow-up patch adding
in a comment in the hwmod file for this.

Regards,
Vaibhav 
