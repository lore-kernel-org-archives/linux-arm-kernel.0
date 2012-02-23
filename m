From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 23 Feb 2012 19:26:56 +0530
Subject: [PATCH 5/6] ARM: OMAP4: suspend: Do not get dsp/tesla out of reset
In-Reply-To: <1330003320-17400-6-git-send-email-t-kristo@ti.com>
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com>
 <1330003320-17400-6-git-send-email-t-kristo@ti.com>
Message-ID: <CAMQu2gzrGnWOUYacg4jvVqgjrNeHfaTJre6O5rNarQSjAuOzLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

$Subject
s/dsp/DSP
s/tesla/TESLA

On Thu, Feb 23, 2012 at 6:51 PM, Tero Kristo <t-kristo@ti.com> wrote:
> From: Rajendra Nayak <rnayak@ti.com>
>
> With no driver handling DSP/TESLA, if brought out of reset, it stays
> active and does not assert standby.
>
Which lead to IVHA PD not transitiong and hence gating CHIP retention.
You may want to add these bits as well.

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---

Patch is fine though script needs to be updated I guess

Regards
Santosh
