From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 21 May 2014 12:09:50 -0400
Subject: [Patch v4 2/5] Power: reset: add bindings for keystone reset
 driver
In-Reply-To: <13696681.6eGQ96hCX4@wuerfel>
References: <1400682454-24535-1-git-send-email-ivan.khoronzhuk@ti.com>
 <5023955.Vhmhn25HgF@wuerfel> <537CCE5A.7030909@ti.com>
 <13696681.6eGQ96hCX4@wuerfel>
Message-ID: <537CCFCE.7070701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 May 2014 12:07 PM, Arnd Bergmann wrote:
> On Wednesday 21 May 2014 19:03:38 Ivan Khoronzhuk wrote:
>>
>> I've slightly confused where should I add these bindings.
>> The main pll controller mostly used by clk driver....
>> As its register set is used also by reset driver it's logically to put 
>> it to bindings/mfd,
>> but pll controller in mfd it's strange....
>>
>> Could you please help to decide where should it be?.
> 
> Put it into Documentation/devicetree/bindings/clock/keystone-pll.txt
> 
I was just about post the same suggestion. Lets do that.

regards,
Santosh
