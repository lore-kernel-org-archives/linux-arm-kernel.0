From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 21 Jul 2014 12:51:04 -0700
Subject: [PATCHv4 2/5] lib/genalloc.c: Add genpool range check function
In-Reply-To: <CAOesGMiKBNDmJhiY-yK0uZmG-MnK82=ffNGxqasLKozqgpQQpw@mail.gmail.com>
References: <1404324218-4743-1-git-send-email-lauraa@codeaurora.org>	<1404324218-4743-3-git-send-email-lauraa@codeaurora.org>
 <CAOesGMiKBNDmJhiY-yK0uZmG-MnK82=ffNGxqasLKozqgpQQpw@mail.gmail.com>
Message-ID: <53CD6F28.3080203@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/9/2014 3:33 PM, Olof Johansson wrote:
> On Wed, Jul 2, 2014 at 11:03 AM, Laura Abbott <lauraa@codeaurora.org> wrote:
>>
>> After allocating an address from a particular genpool,
>> there is no good way to verify if that address actually
>> belongs to a genpool. Introduce addr_in_gen_pool which
>> will return if an address plus size falls completely
>> within the genpool range.
>>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> 
> Reviewed-by: Olof Johansson <olof@lixom.net>
> 
> What's the merge path for this code? Part of the arm64 code that needs
> it, I presume?
> 

My plan was to have the entire series go through the arm64 tree unless
someone has a better idea.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
