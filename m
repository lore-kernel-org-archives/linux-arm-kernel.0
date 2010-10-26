From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Tue, 26 Oct 2010 09:55:39 -0500
Subject: [PATCH 0/8] staging: tidspbridge - misc fixes
In-Reply-To: <1288103059-notmuch-felipe.contreras@nokia.com>
References: <1288054306-4361-1-git-send-email-x0095840@ti.com>
	<20101026040619.GA8549@suse.de>
	<1288103059-notmuch-felipe.contreras@nokia.com>
Message-ID: <AANLkTimgpj3iU3xQ8K7iwjMuaH3efgzsZfkzZU-H8Fxc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 26, 2010 at 9:43 AM, Felipe Contreras
<felipe.contreras@nokia.com> wrote:
> gregkh at suse.de wrote:
>> On Mon, Oct 25, 2010 at 07:51:38PM -0500, Fernando Guzman Lugo wrote:
>> > This set of patches fix some issues found in lastest tree.
>> >
>> > Fernando Guzman Lugo (8):
>> > ? staging: tidspbridge - remove req_addr from proc_map
>> > ? staging: tidspbridge - add kconfig parameter for DMM size
>> > ? staging: tidspbridge - change mmufault tasklet to a workqueue
>> > ? staging: tidspbridge - fix timeout in dsp_gpt_wait_overflow
>> > ? staging: tidspbridge - use GTP7 for DSP stack dump
>> > ? staging: tidspbridge - remove disabling twl when printing DSP stack
>> > ? staging: tidspbridge - fix some issues after iommu patches
>> > ? staging: tidspbridge - make sync_wait_on_event interruptible
>>
>> Are any of these really applicable for .37 after .37-rc1? ?Or can they
>> wait for .38?
>
> As of right now the dspbridge doesn't work, and there's a mess of
> dependencies to get it working.

Just to note that there will be one more dependency for SCM changes[1]
that will fix compilation, as these need to climb from linux-omap (if
accepted) before applying tidspbridge chunks.

Regards,
Omar

---
[1] http://marc.info/?l=linux-omap&m=128779652429922&w=2
