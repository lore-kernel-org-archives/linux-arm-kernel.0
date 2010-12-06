From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Mon, 6 Dec 2010 02:51:46 -0600
Subject: [PATCH 8/8] staging: tidspbridge - make sync_wait_on_event
	interruptible
In-Reply-To: <AANLkTinnLb9DLMKfxEs_KqMvOmegSDYRuLWh5y=hhBCe@mail.gmail.com>
References: <1288054306-4361-1-git-send-email-x0095840@ti.com>
	<1288054306-4361-2-git-send-email-x0095840@ti.com>
	<1288054306-4361-3-git-send-email-x0095840@ti.com>
	<1288054306-4361-4-git-send-email-x0095840@ti.com>
	<1288054306-4361-5-git-send-email-x0095840@ti.com>
	<1288054306-4361-6-git-send-email-x0095840@ti.com>
	<1288054306-4361-7-git-send-email-x0095840@ti.com>
	<1288054306-4361-8-git-send-email-x0095840@ti.com>
	<1288054306-4361-9-git-send-email-x0095840@ti.com>
	<AANLkTinnLb9DLMKfxEs_KqMvOmegSDYRuLWh5y=hhBCe@mail.gmail.com>
Message-ID: <AANLkTikkBk5N1v7s4r=4tJiBty1LYu3YpzaMGB=RXLwt@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 25, 2010 at 5:17 PM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
> So that avoid nonkillable process.
>
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> ---
>  .../staging/tidspbridge/include/dspbridge/sync.h   |   13 +++++++++++--
>  1 files changed, 11 insertions(+), 2 deletions(-)

Pushed to dspbridge.

Regards,

Omar
