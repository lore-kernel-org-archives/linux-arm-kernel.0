From: bcm@fixthebug.org (Christian Daudt)
Date: Sat, 14 Dec 2013 00:14:22 -0800
Subject: [PATCH v4 5/8] mmc: sdhci-bcm-kona: Add basic use of clocks
In-Reply-To: <1386271244-3927-6-git-send-email-tim.kryger@linaro.org>
References: <1386271244-3927-1-git-send-email-tim.kryger@linaro.org>
 <1386271244-3927-6-git-send-email-tim.kryger@linaro.org>
Message-ID: <CAEPRUYrPXf7QNzput0bz_UPfytRy1eYgyOJYnH5v2v4DCEKSNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 5, 2013 at 11:20 AM, Tim Kryger <tim.kryger@linaro.org> wrote:
> Enable the external clock needed by the host controller during the
> probe and disable it during the remove.
>
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>

Reviewed-by: Christian Daudt <bcm@fixthebug.org>

Chris,
 Are you ok with me pulling this patch along with the rest of the
patchset into the bcm tree?

 Thanks,
   csd
