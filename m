From: clabbe.montjoie@gmail.com (Corentin LABBE)
Date: Sun, 22 Jun 2014 13:58:38 +0200
Subject: [PATCH v3 2/4] crypto: Update makefile and Kconfig for Security
 System
In-Reply-To: <201406142101.30546.marex@denx.de>
References: <1402404197-4236-1-git-send-email-clabbe.montjoie@gmail.com>
 <1402404197-4236-3-git-send-email-clabbe.montjoie@gmail.com>
 <201406142101.30546.marex@denx.de>
Message-ID: <53A6C4EE.2020400@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 14/06/2014 21:01, Marek Vasut a ?crit :
> On Tuesday, June 10, 2014 at 02:43:15 PM, LABBE Corentin wrote:
>> Add necessary changes for configuring and compiling the Security System
>> driver.
>>
>> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
>> ---
>>  drivers/crypto/Kconfig  | 91
>> +++++++++++++++++++++++++++++++++++++++++++++++++ drivers/crypto/Makefile
>> |  1 +
>>  2 files changed, 92 insertions(+)
> 
> This should be part of 1/4, otherwise 1/4 just adds dead code.
> 

If I do that 1/4 add to the makefile a path that do not exists.

But as you like I will change that.
