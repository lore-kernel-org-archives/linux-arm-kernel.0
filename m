From: bcm@fixthebug.org (Christian Daudt)
Date: Mon, 23 Dec 2013 00:26:01 -0800
Subject: [PATCH v4 5/8] mmc: sdhci-bcm-kona: Add basic use of clocks
In-Reply-To: <CAEPRUYrPXf7QNzput0bz_UPfytRy1eYgyOJYnH5v2v4DCEKSNA@mail.gmail.com>
References: <1386271244-3927-1-git-send-email-tim.kryger@linaro.org>
 <1386271244-3927-6-git-send-email-tim.kryger@linaro.org>
 <CAEPRUYrPXf7QNzput0bz_UPfytRy1eYgyOJYnH5v2v4DCEKSNA@mail.gmail.com>
Message-ID: <CAEPRUYphct9jJkB7kT=vqmGKX86AQMaZvhxEqChGzizGCS6d1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 14, 2013 at 12:14 AM, Christian Daudt <bcm@fixthebug.org> wrote:
> On Thu, Dec 5, 2013 at 11:20 AM, Tim Kryger <tim.kryger@linaro.org> wrote:
>> Enable the external clock needed by the host controller during the
>> probe and disable it during the remove.
>>
>> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
>> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
>> Reviewed-by: Matt Porter <matt.porter@linaro.org>
>
> Reviewed-by: Christian Daudt <bcm@fixthebug.org>
>
> Chris,
>  Are you ok with me pulling this patch along with the rest of the
> patchset into the bcm tree?
>
>  Thanks,
>    csd
Hi Chris,
 I'm hoping to get this patchset and "rename ARCH_BCM to
ARCH_BCM_MOBILE (mmc)" patch into 3.14 still, and these 2 patches are
waiting for your ack and confirmation that you're ok with me pulling
them through armsoc. Can you pls review them ?

 Thanks,
  csd
