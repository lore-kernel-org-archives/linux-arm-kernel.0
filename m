From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Fri, 5 Oct 2018 23:20:07 +0200
Subject: [PATCH] mmc: meson-mx-sdio: mark expected switch fall-through
In-Reply-To: <CAFBinCDWUO74R_GKBJCmGRNSz=b75zxj4XB8LnYuQjdW9ecGLA@mail.gmail.com>
References: <20181005100903.GA32057@embeddedor.com>
 <CAFBinCDWUO74R_GKBJCmGRNSz=b75zxj4XB8LnYuQjdW9ecGLA@mail.gmail.com>
Message-ID: <1768f2bf-4253-e071-a93a-6ec2e19fc256@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On 10/5/18 11:10 PM, Martin Blumenstingl wrote:
> On Fri, Oct 5, 2018 at 12:15 PM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>>
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Notice that in this particular case, I replaced the "fall-through:"
>> comment with a proper "fall through", which is what GCC is
>> expecting to find.
>>
>> Addresses-Coverity-ID: 1373880 ("Missing break in switch")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> thank you for taking care of this!
> 

Glad to help. :)

Thanks
--
Gustavo
