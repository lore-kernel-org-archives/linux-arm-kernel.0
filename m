From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 2 Nov 2015 07:44:26 -0600
Subject: [PATCH DRAFT 1/2] drivers: serial: PL011: refactor register access
In-Reply-To: <563767C9.7050206@arm.com>
References: <1446467042-24494-1-git-send-email-andre.przywara@arm.com>
 <1446467042-24494-2-git-send-email-andre.przywara@arm.com>
 <563764B7.6040202@codeaurora.org> <563767C9.7050206@arm.com>
Message-ID: <563768BA.8080109@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andre Przywara wrote:
> This patch doesn't, I was just enumerating possible extensions which
> will become much easier now that we don't have to patch every single
> call site for such a change (to give rationale for this refactoring).
> Changing the access width is now a simple change in those two functions,
> and since you have the struct uart_amba_port available, you can access
> any field in there to determine your desired access width.
>
> As it says on the tin: it's a draft. Feel free to extend it to a proper
> series;-)

Actually, we already have a patch that does just that, so I'll post it.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
