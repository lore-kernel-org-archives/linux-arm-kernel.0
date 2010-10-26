From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Tue, 26 Oct 2010 03:58:59 +0300
Subject: [PATCH 8/8] staging: tidspbridge - make sync_wait_on_event
	interruptible
In-Reply-To: <1288054306-4361-9-git-send-email-x0095840@ti.com>
References: <1288054306-4361-1-git-send-email-x0095840@ti.com>
	<1288054306-4361-2-git-send-email-x0095840@ti.com>
	<1288054306-4361-3-git-send-email-x0095840@ti.com>
	<1288054306-4361-4-git-send-email-x0095840@ti.com>
	<1288054306-4361-5-git-send-email-x0095840@ti.com>
	<1288054306-4361-6-git-send-email-x0095840@ti.com>
	<1288054306-4361-7-git-send-email-x0095840@ti.com>
	<1288054306-4361-8-git-send-email-x0095840@ti.com>
	<1288054306-4361-9-git-send-email-x0095840@ti.com>
Message-ID: <AANLkTinnLb9DLMKfxEs_KqMvOmegSDYRuLWh5y=hhBCe@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 26, 2010 at 3:51 AM, Fernando Guzman Lugo <x0095840@ti.com> wrote:
> So that avoid non-killable process.

It would be useful to interrupt these tasks from user-space. A
separate ioctl to do that would be needed.

-- 
Felipe Contreras
