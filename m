From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 6 Mar 2017 11:22:54 -0800
Subject: [PATCH 1/1] ARM: dts: NSP: Add crypto (SPU) to dtsi
In-Reply-To: <66ba937a-f1c3-1cae-ff2e-46a9d9c97344@gmail.com>
References: <1487798543-34229-1-git-send-email-steven.lin1@broadcom.com>
 <66ba937a-f1c3-1cae-ff2e-46a9d9c97344@gmail.com>
Message-ID: <fd877ab2-48db-a677-b539-ba5ed55e75c6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2017 12:31 PM, Florian Fainelli wrote:
> On 02/22/2017 01:22 PM, Steve Lin wrote:
>> Adds crypto hardware (SPU) to Northstar Plus device tree file.
>>
>> Signed-off-by: Steve Lin <steven.lin1@broadcom.com>
> 
> Applied, thanks!

And dropped, since there is a dependency on "ARM: dts: NSP: Add mailbox
(PDC) to NSP" to be applied first.

Let's wait for the mailbox maintainer to chime in before I apply the
following patches (in that order):

ARM: dts: NSP: Add mailbox (PDC) to NSP
ARM: dts: NSP: Add crypto (SPU) to dtsi

Thanks!
-- 
Florian
