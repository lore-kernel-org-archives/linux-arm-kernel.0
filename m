From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 17 Mar 2017 15:50:02 -0700
Subject: [PATCH 1/1] ARM: dts: NSP: Add crypto (SPU) to dtsi
In-Reply-To: <fd877ab2-48db-a677-b539-ba5ed55e75c6@gmail.com>
References: <1487798543-34229-1-git-send-email-steven.lin1@broadcom.com>
 <66ba937a-f1c3-1cae-ff2e-46a9d9c97344@gmail.com>
 <fd877ab2-48db-a677-b539-ba5ed55e75c6@gmail.com>
Message-ID: <ff62a275-25c7-2f68-7d15-67e533208ad2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2017 11:22 AM, Florian Fainelli wrote:
> On 02/28/2017 12:31 PM, Florian Fainelli wrote:
>> On 02/22/2017 01:22 PM, Steve Lin wrote:
>>> Adds crypto hardware (SPU) to Northstar Plus device tree file.
>>>
>>> Signed-off-by: Steve Lin <steven.lin1@broadcom.com>
>>
>> Applied, thanks!
> 
> And dropped, since there is a dependency on "ARM: dts: NSP: Add mailbox
> (PDC) to NSP" to be applied first.
> 
> Let's wait for the mailbox maintainer to chime in before I apply the
> following patches (in that order):
> 
> ARM: dts: NSP: Add mailbox (PDC) to NSP
> ARM: dts: NSP: Add crypto (SPU) to dtsi

Applied again.
-- 
Florian
