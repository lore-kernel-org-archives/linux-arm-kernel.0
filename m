From: ruslan.bilovol@ti.com (Ruslan Bilovol)
Date: Fri, 16 Aug 2013 15:04:29 +0300
Subject: [PATCH v2 0/2] omap4/twl6030: typical connection to omap4 as a
 separate dtsi file
In-Reply-To: <520B8B45.1010300@baylibre.com>
References: <1376469348-10797-1-git-send-email-ruslan.bilovol@ti.com>
 <520B8B45.1010300@baylibre.com>
Message-ID: <CAB=otbTUk68CLmgQsEoefMMFTAnZCAMbZa-yiYmn1b3F1X8BiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Wed, Aug 14, 2013 at 4:51 PM, Benoit Cousson <bcousson@baylibre.com> wrote:
> Hi Ruslan,
>
> On 14/08/2013 10:35, Ruslan Bilovol wrote:
>>
>> Hello,
>>
>> There is no functional changes between v1 and v2 - just
>> added the patch for omap4-var-som - Uri Yosef confirmed
>> this board have the same connection of OMAP4<->TWL6030 as
>> SDP4430 board
>
>
> The series looks good to me, but it will be good to have a test for Panda
> and Variscite boards before merging it.

Okay, so I just verified this patch series on PandaBoard ES2. Should I
resubmit this series with
fixed commit message?
However I cannot verify the patch for Variscite board because I do not
own any such board so
you can drop that patch. But maybe Uri Yosef can verify it. Uri?

>
> Regards,
> Benoit

-- 
Best regards,
Ruslan Bilvol
