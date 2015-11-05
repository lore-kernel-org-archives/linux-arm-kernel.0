From: kaloz@openwrt.org (Imre Kaloz)
Date: Thu, 05 Nov 2015 12:03:03 +0100
Subject: [PATCH 1/4] ARM: dts: kirkwood: add Linksys EA4500
In-Reply-To: <3957044.Sz6eC5OsVr@wuerfel>
References: <00000150d49a7cf7-e97bf540-89ce-49bf-a25e-2d082acab273-000000@email.amazonses.com>
 <3957044.Sz6eC5OsVr@wuerfel>
Message-ID: <op.x7mjnduz2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 04 Nov 2015 23:41:01 +0100, Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday 04 November 2015 22:25:05 Luka Perkov wrote:
>> +/ {
>> +	model = "Linksys EA4500";
>> +	compatible = "linksys,ea4500", "marvell,kirkwood-88f6282",  
>> "marvell,kirkwood";
>
> According to https://wikidevi.com/wiki/Linksys_EA4500 there are multiple  
> versions
> of this device, and at least EA4500v3 is completely incompatible with  
> the version
> in this patch. Should we add "linksys,ea4500v1" as a compatible string  
> to identify
> this better?

Not sure, as "v1" is never marked on the box/boards, and for this reason  
as far as I remember, we've never marked "v1" on any upstream code (unlike  
vX).


Imre
