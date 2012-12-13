From: martinez.javier@gmail.com (Javier Martinez Canillas)
Date: Fri, 14 Dec 2012 00:58:53 +0100
Subject: [PATCH 1/1] ARM: OMAP2+: omap2plus_defconfig: enable twl4030 SoC
 audio
In-Reply-To: <50B48EB2.1040804@ti.com>
References: <1353979275-6237-1-git-send-email-javier.martinez@collabora.co.uk>
 <50B48EB2.1040804@ti.com>
Message-ID: <CAAwP0s2p+eSe5Xzip+vOtOhKFNsbdLsqcHy7CcFVv7O8CAXmdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 10:58 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 11/27/2012 02:21 AM, Javier Martinez Canillas wrote:
>> Many TI OMAP SoC based boards that uses twl4030 as codec have
>> been updated to use the unified audio driver (omap-twl4030)
>> since they have similar audio setup.
>>
>> So, is good to have it built to add audio support to these boards.
>>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>
> I also agree that it is a good practice to enable this in the defconfig.
>
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>

Hi Tony,

Any comments on this patch?

Best regards,
Javier
