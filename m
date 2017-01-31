From: eric@anholt.net (Eric Anholt)
Date: Tue, 31 Jan 2017 10:43:49 -0800
Subject: [PATCH] ARM: bcm2835: dt: add index to the ethernet alias
In-Reply-To: <1485857243.24331.0.camel@v3.sk>
References: <5942321c5d0bfea54eac64ace2b217e8e0b6220d.1485801879.git.baruch@tkos.co.il>
 <1485857243.24331.0.camel@v3.sk>
Message-ID: <87wpdbm5ne.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lubomir Rintel <lkundrak@v3.sk> writes:

> On Mon, 2017-01-30 at 20:44 +0200, Baruch Siach wrote:
>> An alias name should have an index number even when it is the only of
>> its type.
>> This allows U-Boot to add the local-mac-address property. Otherwise
>> U-Boot
>> skips the alias.
>> 
>> Cc: Lubomir Rintel <lkundrak@v3.sk>
>> Fixes: 6a93792774 ("ARM: bcm2835: dt: Add the ethernet to the device
>> trees")
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>
> Acked-by: Lubomir Rintel <lkundrak@v3.sk>

Pulled for dt-next.  Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170131/924a0c7f/attachment.sig>
