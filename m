From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 7 Mar 2017 16:24:28 +0530
Subject: [PATCH v4 1/6] ARM: davinci: da8xx: allow having multiple
 pdata-quirks
In-Reply-To: <1488297720-4558-2-git-send-email-bgolaszewski@baylibre.com>
References: <1488297720-4558-1-git-send-email-bgolaszewski@baylibre.com>
 <1488297720-4558-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <a320742a-dc77-4d73-b3a3-9f3cda66ab04@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 February 2017 09:31 PM, Bartosz Golaszewski wrote:
> We currently bail-out after applying a single quirk. We will want
> to reuse the function doing the vpif capture registration so remove
> the break; and continue iterating over the quirk array.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This patch is not really da8xx specific, so I dropped the da8xx: in
subject line while applying.

Thanks,
Sekhar
