From: saeed.bishara@gmail.com (saeed bishara)
Date: Tue, 3 May 2011 14:12:35 +0300
Subject: [PATCH 1/2] Moving Marvell Dove platform defaults to ARMv7
In-Reply-To: <alpine.LFD.2.00.1105021434230.24613@xanadu.home>
References: <1302173382-25577-1-git-send-email-kostap@marvell.com>
	<BANLkTikCBDCYr6BHz4zWPvHfuAQ+eCtvNg@mail.gmail.com>
	<alpine.LFD.2.00.1105021354410.24613@xanadu.home>
	<alpine.LFD.2.00.1105021434230.24613@xanadu.home>
Message-ID: <BANLkTimdti4Cj2BMqsRdnmOB7Dtt9=QTCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> BTW, does this mean that all PJ4's are ARMv7 capable now?
yes
> If so, can the PJ4 entry in arch/arm/mm/proc-v6.s be removed?
sure, we will prepare a patch that removes the PJ4 from that file and
from arch/arm/boot/compressed/head.S
Haojian, can you please approve?

saeed
