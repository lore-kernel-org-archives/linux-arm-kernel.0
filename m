From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 28 Apr 2014 14:25:37 +0530
Subject: [PATCH v3 2/4] ARM: dts: Add support for DRA72x family of devices
In-Reply-To: <5761706.QaRvAizEZ2@wuerfel>
References: <1398333987-19454-1-git-send-email-rnayak@ti.com>
 <201404241513.54380.arnd@arndb.de> <535DF092.7000307@ti.com>
 <5761706.QaRvAizEZ2@wuerfel>
Message-ID: <535E1789.5020001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 April 2014 02:20 PM, Arnd Bergmann wrote:
> On Monday 28 April 2014 11:39:22 Rajendra Nayak wrote:
>>
>> DRA742 EVM:  Software Developement Board for DRA742
>> compatible = "ti,dra7-evm", "ti,dra742", "ti,dra74", "ti,dra7"
>> DRA722 EVM: Software Development Board for DRA722
>> compatible = "ti,dra72-evm", "ti,dra722", "ti,dra72", "ti,dra7"
>>
>> I was also calling the .dtsi files as dra72x.dtsi and dra74x.dtsi, do you suggest I call
>> them dra742.dtsi and dra722.dtsi instead? Just that if we end up with a dra745 which is
>> fully compatible with dra742, as you mentioned above, we would be using a dra742.dtsi for a dra745
>> device which could be a little confusing.
> 
> For the file names, wildcards are ok. Alternatively you could have
> a dra745.dtsi that does nothing but include dra752.dtsi and override
> the compatible string (if there is one to start with).

Okay, thanks.

> 
> 	Arnd
> 
