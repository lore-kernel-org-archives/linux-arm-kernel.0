From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 26 Aug 2016 11:32:33 +0200
Subject: [PATCH] ARM: kirkwood: ib62x0: fix size of u-boot environment
 partition
In-Reply-To: <20160815210344.GI24664@lunn.ch> (Andrew Lunn's message of "Mon,
 15 Aug 2016 23:03:44 +0200")
References: <1471021970-21248-1-git-send-email-gmbnomis@gmail.com>
 <20160815210344.GI24664@lunn.ch>
Message-ID: <87twe7j2oe.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simpn,
 
 On lun., ao?t 15 2016, Andrew Lunn <andrew@lunn.ch> wrote:

> On Fri, Aug 12, 2016 at 07:12:50PM +0200, Simon Baatz wrote:
>> Commit 148c274ea644 ("ARM: kirkwood: ib62x0: add u-boot environment
>> partition") split the "u-boot" partition into "u-boot" and "u-boot
>> environment".  However, instead of the size of the environment, an offset
>> was given, resulting in overlapping partitions.
>> 
>> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>


Applied on mvebu/fixes

Thanks,

Gregory

>
>     Andrew

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
