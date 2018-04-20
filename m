From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Fri, 20 Apr 2018 09:48:26 +0200
Subject: bq27000: directory/files exists even when hardware is not
 available
In-Reply-To: <20180420074036.GA16257@amd>
References: <20180420074036.GA16257@amd>
Message-ID: <20180420074826.c7cy4z3tq7c56ccs@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 April 2018 09:40:36 Pavel Machek wrote:
> Hi!
> 
> On droid4 (4.17-rc1), /sys/class/power_supply/bq27000-battery exists
> even when hardware is not present (as on Droid 4).
> 
> Any ideas?
> 									Pavel

Somebody must have registered bq device into power_supply subsystem.
Maybe DT note is present?

-- 
Pali Roh?r
pali.rohar at gmail.com
