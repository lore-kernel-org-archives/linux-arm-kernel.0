From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 06 Jul 2011 12:31:44 -0700
Subject: [PATCH v2 00/18] OMAP4: PM data big spring cleanup and fixes
In-Reply-To: <alpine.DEB.2.00.1107060017480.4217@utopia.booyaka.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
	<alpine.DEB.2.00.1107060017480.4217@utopia.booyaka.com>
Message-ID: <4E14B820.6070202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/6/2011 12:19 AM, Paul Walmsley wrote:
> Hi,
>
> On Fri, 1 Jul 2011, Benoit Cousson wrote:
>
>> Here are a bunch of cleanups on almost every PRCM related data files.
>> Some of them are purely code moves, and will look like a lot of
>> noise for nothing, but this is needed if we want to keep the files
>> aligned with generator tool and thus ease the future migration to
>> whatever format (common clock framework + DT).
>
> Thanks.  I'll split these up into smaller topic branches, I think
> that's what Tony wants for this window.
>
> Patches 1-3 and 12 have been queued for 3.1 at
> git://git.pwsan.com/linux-2.6 in the 'prcm_cleanup_a_3.1' branch.
>
> Patches 4-8 and 11 have been queued for 3.1 at
> git://git.pwsan.com/linux-2.6 in the 'clock_cleanup_a_3.1' branch.
>
> Patches 9 and 10 have been split into PRCM changes and clock changes. The
> PRCM changes have been queued for 3.1 at git://git.pwsan.com/linux-2.6 in
> the 'prcm_cleanup_a_3.1' branch.  The clock changes have been queued for
> 3.1 at git://git.pwsan.com/linux-2.6 in the 'clock_cleanup_a_3.1' branch.
>
> Patches 13-15 have been queued for 3.1 at
> git://git.pwsan.com/linux-2.6 in the 'hwmod_cleanup_a_3.1' branch.
>
> Patches 17-18 have been queued for 3.1 at
> git://git.pwsan.com/linux-2.6 in the 'hwmod_dss_fix_3.1' branch.
>
> Patch 16, to me, belongs best with the 4460 support series and so I'll see
> if it makes sense to fit it in there somewhere.

Paul,

Do you want me to base the 4460 support series on one of your branches
and re-post including the above patch?

regards,
Rajendra

>
>
> - Paul
