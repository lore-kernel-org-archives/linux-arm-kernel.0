From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 28 May 2014 14:15:43 +0530
Subject: [PATCH 1/1] ARM: ux500: Staticize ux500_soc_attr
In-Reply-To: <20140528083649.GB10803@lee--X1>
References: <1401248417-10146-1-git-send-email-sachin.kamat@linaro.org>
 <20140528083649.GB10803@lee--X1>
Message-ID: <CAK9yfHwHO_WPaGqJLVxOZrzFCRqBKi+zJPF2-8cDPokcdkb2dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On 28 May 2014 14:06, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 28 May 2014, Sachin Kamat wrote:
>
>> 'ux500_soc_attr' is local to this file. While at it also make it
>> const to match the argument list of device_create_file.
>
> What's going on Sachin?  I Acked v2 of this patch an hour ago, yet
> you've resent it as a v1 and without the Ack?

Actually I posted v2 twice almost immediately. The first time I forgot to
CC LKML as requested by you. Sorry for the confusion.


-- 
With warm regards,
Sachin
