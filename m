From: dann.frazier@canonical.com (Dann Frazier)
Date: Wed, 18 Jun 2014 16:19:45 -0600
Subject: [PATCH v3 3/4] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <20140618221046.GL24024@pd.tnic>
References: <1401761660-11515-1-git-send-email-lho@apm.com>
 <1401761660-11515-2-git-send-email-lho@apm.com>
 <1401761660-11515-3-git-send-email-lho@apm.com>
 <1401761660-11515-4-git-send-email-lho@apm.com>
 <20140618221046.GL24024@pd.tnic>
Message-ID: <CALdTtnte5M=G5qyChM2iegkivdgsRM=23ezcHNGVuPYN24LXhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 4:10 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Jun 02, 2014 at 08:14:19PM -0600, Loc Ho wrote:
>> This patch adds support for the APM X-Gene SoC EDAC driver and
>> requires ARM64 EDAC support patch [1] to compile.
>>
>> [1] http://www.spinics.net/lists/arm-kernel/msg324093.html
>>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>> Signed-off-by: Loc Ho <lho@apm.com>
>
> This is starting to look ok, I'd guess it needs to go after the atomic
> scrub patch goes in, right?

Yeah, he mentions that dependency in patch #3. fwiw, I tested this set
together and it is working fine for me.

Tested-by: dann frazier <dann.frazier@canonical.com>

 -dann

> Also, I'd need the device tree pieces acked by device tree maintainers
> before I pick them up together with this driver.
>
> Thanks.
>
> --
> Regards/Gruss,
>     Boris.
>
> Sent from a fat crate under my desk. Formatting is fine.
> --
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
