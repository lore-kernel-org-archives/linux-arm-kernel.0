From: davidb@codeaurora.org (David Brown)
Date: Mon, 13 Dec 2010 08:35:11 -0800
Subject: [PATCH 0/5 v3] SMP support for msm
In-Reply-To: <1292203221-2609-1-git-send-email-y>
References: <1292203221-2609-1-git-send-email-y>
Message-ID: <20101213163511.GA10659@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 12, 2010 at 05:20:15PM -0800, ykaoua at qualcomm.com wrote:
> From: Jeff Ohlstein <johlstei@codeaurora.org>
> 
> This series adds support for SMP on msm targets, and specifically adds
> support for SMP on the msm8x60. This version is rebased on top of
> Russell's SMP and gic patches, and doesn't need to change dma-mapping.

Heh.  These are supposed to be from Jeff Ohlstein, not ykaoua.  Jeff,
when you incorporate fixes, please make sure the series gets sent from
your address.

Yvonne, apologies that you'll be getting all of the replies to this
thread, please ignore them.

As far as I can tell, what happened is that 'git send-email' asks to
confirm the email address.  It's not a question, so if you type 'y',
it happily sends the email from 'y', which in our case expands to the
ykaoua user.

David
