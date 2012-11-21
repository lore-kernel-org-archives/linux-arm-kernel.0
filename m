From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Thu, 22 Nov 2012 08:43:46 +0900
Subject: [PATCH] ARM: kirkwood: Add Plat'Home OpenBlocks A6 support
In-Reply-To: <CABMQnVKPyEp-cm_M_Y4rSU_tNLHL0fhUKUUgZkTkV+8MhnjVdA@mail.gmail.com>
References: <1352792590-20052-1-git-send-email-iwamatsu@nigauri.org>
 <20121113123739.GS22042@titan.lakedaemon.net>
 <CABMQnVKPyEp-cm_M_Y4rSU_tNLHL0fhUKUUgZkTkV+8MhnjVdA@mail.gmail.com>
Message-ID: <CABMQnVL7bd7Om-7nZ33Y336PPtdMLmMWx63YwtMOZf5NftkeOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Jason.

On Wed, Nov 14, 2012 at 4:54 AM, Nobuhiro Iwamatsu <iwamatsu@nigauri.org> wrote:
> Hi,
>
> On Tue, Nov 13, 2012 at 9:37 PM, Jason Cooper <jason@lakedaemon.net> wrote:
>> Nobuhiro,
>>
>> On Tue, Nov 13, 2012 at 04:43:09PM +0900, Nobuhiro Iwamatsu wrote:
>>> Add support for Plat'Home OpenBlocks A6 using the device tree
>>> where possible.
>>> This commit supports SATA, USB, ether and serial console.
>>>
>>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>>> ---
>>> V2:
>>>   - Remove unnecessary value from bootargs.
>>>   - Update comment for MPP table.
>>>   - Remove kirkwood_uart0_init().
>>
>> Thanks for the patch.  One small note.  In the future, please add a 'V2'
>> to the subject line, eg "[PATCH V2] ...".  It really helps us keep track of
>> which one to merge.
>
> Although I knew about it , I forgot adding "V2".
>
>>
>> No need to resend, I'll keep track of it since I'm about to pull
>> everything together over the next few days.

Where have you managed this patch?  http://git.infradead.org/ ?
I would like to put this into 3.8.  And I would like to follow some
functions (clock frame work etc.) updated.

Best regards,
  Nobuhiro

-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
