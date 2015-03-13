From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 13 Mar 2015 09:01:08 +0100
Subject: [PATCH v6 5/6] ARM: dts: add wl12xx/wl18xx bindings
In-Reply-To: <1426162154-8716-6-git-send-email-eliad@wizery.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
 <1426162154-8716-6-git-send-email-eliad@wizery.com>
Message-ID: <CABxcv=mETO9ESVa04YjRO1d-h5ksEwvwGKb1G-jxVk6ttr9JYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eliad,

On Thu, Mar 12, 2015 at 1:09 PM, Eliad Peller <eliad@wizery.com> wrote:
> Replace all the pdata-quirks for setting wl12xx/wl18xx
> platform data with proper DT definitions.
>
> The patch was compile-tested only.
>
> Signed-off-by: Eliad Peller <eliad@wizery.com>
> ---

I wanted to test your series but I realized that the IGEPv2 I've
access is the old revision that has another SDIO wlan module instead
of a Wilink8.

Maybe Enric have the new revision? I also added to Pau Pajuel as cc
who still works in the company manufacturing these boards so he should
be able to test it.

But in any case, your patch looks good to me so for the
arch/arm/boot/dts/omap3-igep00* changes:

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>

Best regards,
Javier
