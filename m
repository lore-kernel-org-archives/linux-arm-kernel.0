From: hechtb@gmail.com (Bastian Hecht)
Date: Wed, 9 Jan 2013 17:13:15 +0100
Subject: [PATCH 2/2] ARM: shmobile: armadillo800eva: Reference DT
 implementation
In-Reply-To: <20130109020712.GC6496@verge.net.au>
References: <1355851359-8871-1-git-send-email-hechtb+renesas@gmail.com>
 <1355851359-8871-3-git-send-email-hechtb+renesas@gmail.com>
 <20130109020712.GC6496@verge.net.au>
Message-ID: <CABYn4sxsSMSosAVT8DZDupNP9m-vQN+88R2nyC58L-tcNW044Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

2013/1/9 Simon Horman <horms@verge.net.au>:
> On Tue, Dec 18, 2012 at 06:22:39PM +0100, Bastian Hecht wrote:
>> Provide alternate board code for the Armadillo 800 EVA to
>> demonstrate how DT may be used given the current state of
>> driver device tree support. This is intended to act as a
>> reference for mach-shmobile developers.
>>
>> This is based on Simon Horman's reference implementation for
>> the board kzm9g.
>>
>> Currently only the ethernet controller is brought up.
>
> Thanks, looks good. I will apply this.

Thanks!

> Could you let me know what the status of
> the DT bindings for sh-eth is?

I used the bindings that comply to the patch  "[v2,1/2] net: sh_eth:
Add support of device tree probe" from 10/16/2012 from Iwamatsu-san. I
hasn't found its way into v3.8-rc2 yet and I don't know anything more
accurate about the merge process.

Cheers,

 Bastian
