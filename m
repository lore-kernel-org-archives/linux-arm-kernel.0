From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 15 Sep 2014 18:58:40 +0200
Subject: [PATCH 0/2] ARM: at91: Further PIT improvements
In-Reply-To: <201409151852.08178.arnd@arndb.de>
References: <1410789744-23975-1-git-send-email-maxime.ripard@free-electrons.com>
 <201409151852.08178.arnd@arndb.de>
Message-ID: <54171AC0.7060005@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/09/2014 18:52, Arnd Bergmann :
> On Monday 15 September 2014, Maxime Ripard wrote:
>> These patches are meant to address Arnd comments and are based on
>> Nicolas' at91-3.18-drivers2 branch.
>>
>> They basically just remove the early_platform devices, and keep the
>> old mechanism with a function exported by the PIT timer and called by
>> the board files.
>>
> 
> 
> Looks good to me,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd: feel free to add your tag to the patches in the
pull-request that I've sent ([GIT PULL] at91: drivers for 3.18 #2 (bis)).

Best regards,
-- 
Nicolas Ferre
