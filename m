From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 27 Apr 2012 20:53:40 +0100
Subject: [PATCH] ARM: ux500: Fix build error caused by recent variable
 name change
In-Reply-To: <CACRpkdaRdn+q2ODUir6dE8btB8+RTkCYsN0W-Zsj7mkRDNrHQw@mail.gmail.com>
References: <1335541015-10155-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdaRdn+q2ODUir6dE8btB8+RTkCYsN0W-Zsj7mkRDNrHQw@mail.gmail.com>
Message-ID: <4F9AF944.5090309@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/04/12 18:48, Linus Walleij wrote:
> On Fri, Apr 27, 2012 at 5:36 PM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> error: ?u8500_soc_node? undeclared (first use in this function)
>>
>> Was recently changed to 'u8500_local_bus_nodes'.
>>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>
> IIRC I already fixed this up when applying the patch renaming the node.
>
> Can you check the ux500-core branch on my linux-stericsson tree?

Just did.

Seemingly the patch was complete after all (I could have sworn that I 
tested it). I have no idea how I lost it from my own tree though.

Scrap this then.

/Lee
