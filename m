From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Wed, 15 May 2013 11:44:47 -0500
Subject: [PATCH 1/5] ARM: socfpga: dts: Add ethernet bindings for SOCFPGA
In-Reply-To: <201305151519.08598.arnd@arndb.de>
References: <1368571955-6652-1-git-send-email-dinguyen@altera.com>
 <201305151519.08598.arnd@arndb.de>
Message-ID: <5193BB7F.8030404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 05/15/2013 08:19 AM, Arnd Bergmann wrote:
> On Wednesday 15 May 2013, dinguyen at altera.com wrote:
>>                 };
>>  
>> +               ethernet at ff700000 {
>> +                       phy-mode = "gmii";
>> +               };
>> +
>> +               ethernet at ff702000 {
>> +                       status = "disabled";
>> +               };
> 
> By convention, please mark the controllers as "disabled" in the main .dtsi file
> and only enable them in the board specific files when used, rather than the
> other way round.

Thanks for the review. Will fix.

Dinh
> 
> 	Arnd
> 
