From: peter@korsgaard.com (Peter Korsgaard)
Date: Wed, 13 Jan 2016 15:22:12 +0100
Subject: [PATCH v2 1/2] regulator: act8945a: add regulator driver for
 ACT8945A
In-Reply-To: <1452586629-1117-2-git-send-email-wenyou.yang@atmel.com> (Wenyou
 Yang's message of "Tue, 12 Jan 2016 16:17:08 +0800")
References: <1452586629-1117-1-git-send-email-wenyou.yang@atmel.com>
 <1452586629-1117-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <87oacp5zl7.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Wenyou" == Wenyou Yang <wenyou.yang@atmel.com> writes:

 > This patch adds new regulator driver to support ACT8945A MFD
 > chip's regulators.

 > The ACT8945A has three step-down DC/DC converters and four
 > low-dropout regulators.

 > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Isn't the regulator part of the act8945a identical to act8865? Can't we
just use the existing act8865-regulator.c driver? (E.G. support 8865
variant in the mfd driver, but only register the regulator sub device?)

-- 
Bye, Peter Korsgaard
