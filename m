From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 6 Jul 2016 09:06:55 +0200
Subject: [crypto] [marvell-cesa] Driver hangs on Armada 385 device
In-Reply-To: <577b73e7.d5052e0a.d3d9a.ffffaa71@mx.google.com>
References: <577b73e7.d5052e0a.d3d9a.ffffaa71@mx.google.com>
Message-ID: <20160706090655.283ef69d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 05 Jul 2016 11:46:30 +0300, radioconfusion at gmail.com wrote:

> My Armada 385 -device hangs when using marvell-cesa -driver.
> I'm using Linux 4.4.10 and armada-385-db-ap.dts.
> I have also tried with the driver version of Linux 4.7-rc3.
> 
> Please see https://bugzilla.kernel.org/show_bug.cgi?id=120111 for details.

Can you try with
http://git.infradead.org/linux-mvebu.git/commitdiff/c5379ba8fccd99d5f99632c789f0393d84a57805
applied ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
