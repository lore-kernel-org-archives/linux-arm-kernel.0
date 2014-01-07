From: tim.kryger@linaro.org (Tim Kryger)
Date: Tue, 7 Jan 2014 11:37:38 -0800
Subject: [PATCH v4 5/8] mmc: sdhci-bcm-kona: Add basic use of clocks
In-Reply-To: <CAEPRUYrPXf7QNzput0bz_UPfytRy1eYgyOJYnH5v2v4DCEKSNA@mail.gmail.com>
References: <1386271244-3927-1-git-send-email-tim.kryger@linaro.org>
 <1386271244-3927-6-git-send-email-tim.kryger@linaro.org>
 <CAEPRUYrPXf7QNzput0bz_UPfytRy1eYgyOJYnH5v2v4DCEKSNA@mail.gmail.com>
Message-ID: <CAAYSxhoCrveHd5Wkc7Z0qzpGr41qG6-neYSSsuHQuC7AcuJmZQ@mail.gmail.com>
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

Chris,

Can you please provide an answer to csd?

Thanks,
Tim Kryger
