From: cooloney@gmail.com (Bryan Wu)
Date: Mon, 5 Aug 2013 15:50:15 -0700
Subject: [PATCH] leds: leds-ns2: depends on ARCH_KIRKWOOD
In-Reply-To: <20130803181648.GF13555@titan.lakedaemon.net>
References: <1375369655-1310-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375454798-6849-1-git-send-email-simon.guinot@sequanux.org>
 <20130803181648.GF13555@titan.lakedaemon.net>
Message-ID: <CAK5ve-KCjaLfoxBt-nBN_K1CKB=jTYYUPaR4bBmKvfVp-vmfWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 3, 2013 at 11:16 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Fri, Aug 02, 2013 at 04:46:38PM +0200, Simon Guinot wrote:
>> With the DT conversion, the board Kconfig symbols MACH_ are going to be
>> removed. In order to prepare this removal, this patch replaces alls the
>> machines dependencies for leds-ns2 by ARCH_KIRKWOOD.
>>
>> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
>> ---
>> Thomas,
>>
>> Please, insert this patch in your series before the patch named:
>> [PATCHv2 1/9] ARM: kirkwood: convert d2net_v2 to DT
>>
>> Simon
>>
>>  drivers/leds/Kconfig |    5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> Almost missed this one.  This should also go through -leds.
>
> Acked-by: Jason Cooper <jason@lakedaemon.net>
>

Sure, looks good to me and merged into my tree with Jason's Acked-by.

Thanks,
-Bryan
