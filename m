From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 10 Jan 2013 14:31:50 +0100
Subject: [PATCH 2/3] gpio: pca953x: add support for pca9505
In-Reply-To: <CACRpkdYu63TZDpHrGkg0cdqFCrVH1PiNFX8FcrxB9S_Vk9r=kg@mail.gmail.com>
References: <1357493688-25061-1-git-send-email-gregory.clement@free-electrons.com>
 <1357493688-25061-3-git-send-email-gregory.clement@free-electrons.com>
 <CACRpkdYu63TZDpHrGkg0cdqFCrVH1PiNFX8FcrxB9S_Vk9r=kg@mail.gmail.com>
Message-ID: <50EEC2C6.9070109@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2013 12:15 PM, Linus Walleij wrote:
> On Sun, Jan 6, 2013 at 6:34 PM, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
> 
>> Now that pca953x driver can handle GPIO expanders with more than 32
>> bits this patch adds the support for the pca9505 which cam with 40
>> GPIOs.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> Applied, thanks.
> 
Hello Linus,

I think it is a little too early to apply this patch because the 1st
one still have bug and is not yet applied.

So it should be better to wait for that the 1st patch is fine.

Thanks.

> Yours,
> Linus Walleij
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
