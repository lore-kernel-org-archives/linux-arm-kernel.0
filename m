From: matt@genesi-usa.com (Matt Sealey)
Date: Mon, 20 Sep 2010 10:32:51 -0500
Subject: Machine name/id change request
Message-ID: <AANLkTikm78_dj03xxaHMi10V+_B9B_8FRg1kRbL2OPBK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Is it possible for us to change a machine name/id in the database and
future kernels?

We have two systems originally designed by Pegatron and registered
under their codenames, but for now retailing and marketed under the
"Efika MX" brand. We would like to change the id data for

id 2336, originally MX51_LANGE51 but changed to MX51_EFIKAMX (mx51_efikamx etc.)
id 2370, originally MX51_KUNLUN but changed to MX51_EFIKASB (mx51_efikasb etc.)

This just makes it far less confusing when people start looking at
kernel #if's referencing the platform. I believe there is an
MX51_LANGE52 in there too but we do not have any request to change
that at this time (and pretty much for the forseeable future).

I notice there is a directory suffix there (Directory suffix:
mx51) which is not current as of Freescale's MX51 BSP from April, or
mainline 2.6.35 as it has moved to mach-mx5. That probably doesn't
matter anyway.

I guess that's it. Have a fun day, all.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
