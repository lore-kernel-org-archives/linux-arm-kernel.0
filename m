From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 28 Mar 2013 08:07:44 +0100
Subject: [PATCH-V2 5/6] ARM: dts: AM33XX: Fix uart numbering to match
 hardware/TRM
In-Reply-To: <1364452963-22083-6-git-send-email-hvaibhav@ti.com> (Vaibhav
 Hiremath's message of "Thu, 28 Mar 2013 12:12:42 +0530")
References: <1364452963-22083-1-git-send-email-hvaibhav@ti.com>
 <1364452963-22083-6-git-send-email-hvaibhav@ti.com>
Message-ID: <87mwto3su7.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Vaibhav" == Vaibhav Hiremath <hvaibhav@ti.com> writes:

 Vaibhav> With DT support, where naming convention is based on base-addr
 Vaibhav> and not id, so we should follow TRM/Spec numbering label.

 Vaibhav> This patch changes UART numbering as per TRM, as uart0-5.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
