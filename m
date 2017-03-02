From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Mar 2017 13:37:25 +0000
Subject: [PATCH] arm64: restore get_current() optimisation
In-Reply-To: <3deb3450-f02d-68d1-826f-80028091e078@suse.de>
References: <1483468021-8237-1-git-send-email-mark.rutland@arm.com>
 <8928ec99-5f5b-905b-5922-81a009f18999@suse.de>
 <20170302124008.GE19632@leverpostej>
 <3deb3450-f02d-68d1-826f-80028091e078@suse.de>
Message-ID: <20170302133724.GF19632@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 01:43:09PM +0100, Andreas F?rber wrote:
> Am 02.03.2017 um 13:40 schrieb Mark Rutland:
> > On Thu, Mar 02, 2017 at 12:54:24PM +0100, Andreas F?rber wrote:
> >> Hi Mark,
> >>
> >> Am 03.01.2017 um 19:27 schrieb Mark Rutland:
> >>> Commit c02433dd6de32f04 ("arm64: split thread_info from task stack")
> >>> inverted the relationship between get_current() and
> >>> current_thread_info(), with sp_el0 now holding the current task_struct
> >>> rather than the current thead_info. The new implementation of
> >>
> >> "thread_info"?
> > 
> > struct thread_info, as returned by current_thread_info().
> 
> I was pointing out the missing R. :)

Ah; clearly I should invest in some reading glasses... :)

Mark.
