From: netz.kernel@gmail.com (Marty Plummer)
Date: Sat, 27 Aug 2016 13:53:25 -0500
Subject: Older hisilicon chipsets
In-Reply-To: <20160827150457.GM10637@io.lakedaemon.net>
References: <7773f0e5-d045-1e93-529b-74a601467ed1@gmail.com>
 <20160827150457.GM10637@io.lakedaemon.net>
Message-ID: <ec3ec22f-f05e-aaec-8e9a-bfc0565b9e9d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2016 10:04 AM, Jason Cooper wrote:
> 
> Ah, yes.  The same device we were discussing on #mvlinux?
> 
Indeed, the very same
> 
> Note that I have no experience with HiSilicon. :-)  However, I think
> it's correct to add it mach-hisi/.   A quick grep shows that there is
> devicetree support for hisilicon SoCs (arch/arm/boot/dts/).  So that
> means there's a *lot* less code to add under mach-hisi/.
> 
The issue here is that mach-hisi/Kconfig and CONFIG_ARCH_HISI require
ARMv7, whereas the hi3520 has an arm1176/arm926 core, thereby being
ARMv6/v5
> 
> Ideally, most of it will be a devicetree.  Assuming we have code for the
> SoC and associated drivers.
> 
Yes, I've been doing some work on that already, but as I've said, unsure
where one should/would insert all these different things.
> 
> I've added GregKH to the Cc to see if he knows of anyone currently
> working with Hisilicon.
> 
Thanks, mayhaps someone can get even a response from Hisilicon, as I've
yet to recieve even that.
> thx,
> 
> Jason.
> 


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160827/7294fccb/attachment.sig>
