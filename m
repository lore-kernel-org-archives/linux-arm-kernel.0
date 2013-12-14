From: bcm@fixthebug.org (Christian Daudt)
Date: Sat, 14 Dec 2013 00:26:00 -0800
Subject: [PATCH v4 7/8] clocksource: kona: Add basic use of external clock
In-Reply-To: <1386271244-3927-8-git-send-email-tim.kryger@linaro.org>
References: <1386271244-3927-1-git-send-email-tim.kryger@linaro.org>
 <1386271244-3927-8-git-send-email-tim.kryger@linaro.org>
Message-ID: <CAEPRUYqg2hzwudwLq+MyBfY119e22HzBe5H+03vGA4VVrL9rYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 5, 2013 at 11:20 AM, Tim Kryger <tim.kryger@linaro.org> wrote:
> When an clock is specified in the device tree, enable it and use it to
> determine the external clock frequency.
>
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> ---

Reviewed-by: Christian Daudt <bcm@fixthebug.org>

Daniel,
 Are you ok with me pulling this patch in with the rest of the
patchset into the bcm tree ?

 Thanks,
   csd
