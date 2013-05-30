From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 30 May 2013 12:36:09 -0700
Subject: [PATCH v3 0/5] rtc-at91rm9200: add shadow interrupt mask
In-Reply-To: <51A704C3.6010109@atmel.com>
References: <1364983415-20298-1-git-send-email-jhovold@gmail.com>
 <1369298335-24597-1-git-send-email-jhovold@gmail.com>
 <20130529133354.dd181c845ee4e96527483345@linux-foundation.org>
 <CAOCHtYiK8Y6iTnb4dWAE+cKHqEta-64gj+PorSFVGBF5wmg1+Q@mail.gmail.com>
 <51A704C3.6010109@atmel.com>
Message-ID: <20130530123609.6e2966a66dd7b131961ed052@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 May 2013 09:50:27 +0200 Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> The review of this patch series was in my TODO list for some time...
> 
> Today, I magically took time to review it ;-)
> The patch series is good and I (even if it is too late) here is my:
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> I do not know if the series can be stacked for inclusion in 3.10-rc but 
> the resolution of this bug can help a lot (as Douglas is saying in 
> subsequent email...).

We can do that, but looking through the discussion and changelogs I
can't seem to find a usable description of what impact the bug (and its
fix) have upon end-users.

A nicely packaged description of that impact would help grease the
wheels, please.
