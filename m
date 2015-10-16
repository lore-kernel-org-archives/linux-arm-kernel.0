From: agross@codeaurora.org (Andy Gross)
Date: Thu, 15 Oct 2015 21:28:20 -0500
Subject: [GIT PULL] qcom SoC changes for 4.4 *RESEND*
In-Reply-To: <5294153.vxTnuIq2gr@wuerfel>
References: <1444860627-8258-1-git-send-email-agross@codeaurora.org>
 <5294153.vxTnuIq2gr@wuerfel>
Message-ID: <20151016022820.GC23681@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 11:05:27PM +0200, Arnd Bergmann wrote:
> On Wednesday 14 October 2015 17:10:27 Andy Gross wrote:
> > Qualcomm ARM Based SoC Updates for 4.4
> > 
> > * Implement id_table driver matching in SMD
> > * Avoid NULL pointer exception on remove of SMEM
> > * Reorder SMEM/SMD configs
> > * Make qcom_smem_get() return a pointer
> > * Handle big endian CPUs correctly in SMEM
> > * Represent SMD channel layout in structures
> > * Use __iowrite32_copy() in SMD
> > * Remove use of VLAIs in SMD
> > * Handle big endian CPUs correctly in SMD/RPM
> > * Handle big endian CPUs corretly in SMD
> > * Reject sending SMD packets that are too large
> > * Fix endianness issue in SCM __qcom_scm_is_call_available
> > * Add missing prototype for qcom_scm_is_available()
> > * Correct SMEM items for upper channels
> > * Use architecture level to build SCM correctly
> > * Delete unneeded of_node_put in SMD
> > * Correct active/slep state flagging in SMD/RPM
> > * Move RPM message ram out of SMEM DT node
> > 
> 
> Pulled into next/drivers, but please try to make the changelogs more readable
> in the future. No point listing each small patch here, instead say what you've
> done overall and what the major things are. Right now, the merge commit
> just duplicates the information like this:

Fair enough.  I'll condense it next time.  Thanks for the hwspinlock fix on top.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
