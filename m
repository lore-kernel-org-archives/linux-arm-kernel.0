From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 25 Jan 2017 08:55:42 +0100
Subject: [PATCH net-next v6 2/4] net: dsa: mv88e6xxx: Add support for
 ethernet switch 88E6341
In-Reply-To: <20170125020249.GB24034@lunn.ch> (Andrew Lunn's message of "Wed,
 25 Jan 2017 03:02:49 +0100")
References: <cover.b0e18efe751186768e720c341693117fdd4d3c16.1485288602.git-series.gregory.clement@free-electrons.com>
 <bb6e3987ee942277e99c78d1f28112d8b4ecb744.1485288602.git-series.gregory.clement@free-electrons.com>
 <20170125020249.GB24034@lunn.ch>
Message-ID: <8760l3375t.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,
 
 On mer., janv. 25 2017, Andrew Lunn <andrew@lunn.ch> wrote:

>> +	[MV88E6341] = {
>> +		.prod_num = PORT_SWITCH_ID_PROD_NUM_6341,
>> +		.family = MV88E6XXX_FAMILY_6341,
>> +		.name = "Marvell 88E6341",
>> +		.num_databases = 4096,
>> +		.num_ports = 6,
>> +		.port_base_addr = 0x10,
>> +		.global1_addr = 0x1b,
>> +		.age_time_coeff = 15000,
>
> Hi Gregory
>
> Please could you check this timer in the datasheet. There is currently
> a bug in the mv88e6390 support code. I also set it to 15s. But in fact
> it is 3.75 seconds. The 6341 might also use 3.75 seconds.

When I read your series I also thought about it and indeed it is 3.75
seconds. I will fix it.

Thanks,

Gregory


>
>    Thanks
> 	Andrew

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
