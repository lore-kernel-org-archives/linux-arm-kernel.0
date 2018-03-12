From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Mar 2018 15:16:04 +0100
Subject: [REPOST PATCH 0/2] ARM: dts: keystone WDT & ECC support
In-Reply-To: <39eb257b-ee8b-87a4-a414-61b312c5086e@oracle.com>
References: <1520838607-11709-1-git-send-email-t-kristo@ti.com>
 <39eb257b-ee8b-87a4-a414-61b312c5086e@oracle.com>
Message-ID: <CAK8P3a1_OXYQ8yopSc6O2V0+6MP2P+XDrqkWNZ9wr549Cgh-Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2018 at 8:22 AM, santosh.shilimkar at oracle.com
<santosh.shilimkar@oracle.com> wrote:
>
> On 3/12/18 12:10 AM, Tero Kristo wrote:
>>
>> Hi Santosh,
>>
>> Reposted the ECC handler support as per your request, and applied
>> your ack on that. Reposted also patch #1 as that was pending a minor
>> cosmetic fix.
>>
> Thanks.
>
> Hi Arnd,
> Will you be able to apply these two patches to arm-soc dts branch ?
> Do let me know if you want me to send pull request for two patches
> on top of earlier pull request [1]

I applied both now, but a pull request would have been easier since
I had to go hunting for the patches in the linux-arm-kernel mailing list.

My workflow makes it easier to pick up patches sent 'to:arm at kernel.org',
so if you want to avoid having to prepare a branch, you can always just
bounce individual patches there with your added 'Signed-off-by'.

        Arnd
