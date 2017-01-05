From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 4 Jan 2017 20:07:37 -0800
Subject: [PATCHv2 0/5] Support for Marvell switches with integrated CPUs
In-Reply-To: <20170105033641.6212-1-chris.packham@alliedtelesis.co.nz>
References: <20170105033641.6212-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <6c6795d3-06ab-a4f0-78ad-5ecc78c1aa2f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 01/04/17 ? 19:36, Chris Packham a ?crit :
> The 98DX3236, 98DX3336 and 98DX4251 are a set of switch ASICs with
> integrated CPUs. They CPU block is common within these product lines and
> (as far as I can tell/have been told) is based on the Armada XP. There
> are a few differences due to the fact they have to squeeze the CPU into
> the same package as the switch.

It's really great to see these changes, do you have a plan to also add
support for the integrated switch using a DSA/switchdev driver?

Thanks!
-- 
Florian
