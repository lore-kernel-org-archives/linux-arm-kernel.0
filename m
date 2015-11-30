From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 30 Nov 2015 15:16:06 +0100
Subject: [PATCH 1/4] ARM: dt: mvebu: ix4-300d: remove whole flash partition
In-Reply-To: <20151128211129.GK32356@lunn.ch> (Andrew Lunn's message of "Sat,
 28 Nov 2015 22:11:29 +0100")
References: <1448709248-21177-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1448709248-21177-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20151128211129.GK32356@lunn.ch>
Message-ID: <87si3n609l.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian and Andrew,
 
 On sam., nov. 28 2015, Andrew Lunn <andrew@lunn.ch> wrote:

>>On Sat, Nov 28, 2015 at 12:14:05PM +0100, Sebastian Hesselbarth wrote:
>> Current NAND node has an additional flash partition for the whole
>> flash overlapping with real partitions. Remove this partition as
>> the whole flash is already represented by the NAND device itself.
>> 
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>
> Given Benoit comment
>
> Acked-by: Andrew Lunn <andrew@lunn.ch>


Applied on mvebu/dt

Thanks,

Gregory


>
> 	  Andrew

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
