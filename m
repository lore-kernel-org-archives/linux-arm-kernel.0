From: peter@korsgaard.com (Peter Korsgaard)
Date: Mon, 11 Jan 2016 16:25:35 +0100
Subject: [PATCH V2 2/2] serial: bcm2835: add driver for bcm2835-aux-uart
In-Reply-To: <1452344854-2576-3-git-send-email-kernel@martin.sperl.org>
 (kernel@martin.sperl.org's message of "Sat, 9 Jan 2016 13:07:33
 +0000")
References: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org>
 <1452344854-2576-3-git-send-email-kernel@martin.sperl.org>
Message-ID: <87y4bw9lzk.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "kernel" == kernel  <kernel@martin.sperl.org> writes:

 > From: Martin Sperl <kernel@martin.sperl.org>
 > The bcm2835 SOC contains an auxiliary uart, which is very close
 > to the ns16550 with some differences.

 > The big difference is that the uart HW is not using an internal divider
 > of 16 but 8, which results in an effictive baud-rate being twice
 > the requested baud-rate.

 > This driver handles this device correctly and handles the difference in
 > the HW divider by scaling up the clock ba a factor of 2.

s/ba/by/

-- 
Bye, Peter Korsgaard
