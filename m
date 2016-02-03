From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 3 Feb 2016 12:12:31 -0600
Subject: [PATCH v10 4/5] Watchdog: introduce ARM SBSA watchdog driver
In-Reply-To: <CADyBb7vRTz9NxEmeGvxDooUUUXPPFFcNsjUADHcmSKHS56ZYjA@mail.gmail.com>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-5-git-send-email-fu.wei@linaro.org>
 <56B23D61.2050001@codeaurora.org>
 <CADyBb7tteV7VF9oxMaq5NprVdS2UBKobupxoyfSp+jQwp5wmQA@mail.gmail.com>
 <56B23FE1.2010207@codeaurora.org>
 <CADyBb7vRTz9NxEmeGvxDooUUUXPPFFcNsjUADHcmSKHS56ZYjA@mail.gmail.com>
Message-ID: <56B2430F.4070708@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fu Wei wrote:
> static const struct platform_device_id sbsa_gwdt_pdev_match[] = {
>   { .name = "sbsa-gwdt", },
>   {},
> };
> MODULE_DEVICE_TABLE(platform, sbsa_gwdt_pdev_match);

Ok, thanks.
