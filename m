From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 21 Aug 2013 12:44:18 +0200
Subject: [PATCH v5 0/3] i2c-mv64xxx: Fixes and new feature for controlers
 embedded in Aramda XP
In-Reply-To: <20130820190714.GB24466@katana>
References: <1376039158-1896-1-git-send-email-gregory.clement@free-electrons.com>
 <5213979B.4050306@free-electrons.com> <20130820190714.GB24466@katana>
Message-ID: <52149A02.1000504@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/08/2013 21:07, Wolfram Sang wrote:
> 
>> Jason Cooper drooped the third patch as it conflicted with a patch from Maxime Ripard which adds the AllWinner support. Olof also asked a formal acked-by from a device tree maintainer
>> even if we already answer to Mark Rutland request.
>> 
>> Olof also requested that you take the binding update, so I am going to send a new version of this patch set with the last patch split in two parts.
> 
> Yeah, I wondered about the binding already being accepted when the driver review was not done.

As there will be a conflict for the
Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt file with the
commit "i2c: mv64xxx: Document the newly introduced allwinner
compatible", do you want that I rebase my patch set on your
i2c/for-current branch, or do you prefer to take care of the merge
conflict yourself?

> 
>> As explained earlier today, unless you really want I use be32_to_cpu in the mv64xxx_i2c_offload_msg() I won't change anything else.
> 
> I found some more (minor) issues. Expect a review by tomorrow evening.
> 

Ok I will wait for your review to send the new version

Thanks,
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
