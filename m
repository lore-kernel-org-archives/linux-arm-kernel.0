From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 2 Aug 2018 13:46:57 +0200
Subject: [PATCH] ARM: shmobile: gose: Add DA9210 node for CPU DVFS
In-Reply-To: <20180802112345.nnb6zcnq5t3cxvnu@verge.net.au>
References: <20180730111726.5526-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdUop4fUTbgh0iCQRWTNz_X49070qPKZc0iJ9xFvhi9RHA@mail.gmail.com>
 <20180802112345.nnb6zcnq5t3cxvnu@verge.net.au>
Message-ID: <08920867-e6c9-e89c-7fc9-aa047a6fd44a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2018 01:23 PM, Simon Horman wrote:
> On Wed, Aug 01, 2018 at 02:16:14PM +0200, Geert Uytterhoeven wrote:
>> Hi Marek,
>>
>> On Mon, Jul 30, 2018 at 1:17 PM Marek Vasut <marek.vasut@gmail.com> wrote:
>>> Add DA9210 DVFS node to the I2C bus and link it to CPU0 for DVFS.
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>
>> Thanks for your patch!
>>
>> Oneline-summary prefix should be "ARM: dts: gose:".
>>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Thanks, applied with that fixed.

Oh, was about to send V2. Thanks, this saves me a minute.

-- 
Best regards,
Marek Vasut
