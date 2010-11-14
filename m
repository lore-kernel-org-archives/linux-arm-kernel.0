From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 14 Nov 2010 10:11:26 +0000
Subject: [PATCH v2 20/20] ARM: LPAE: Add the Kconfig entries
In-Reply-To: <4CDE86C3.9080407@ru.mvista.com>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-21-git-send-email-catalin.marinas@arm.com>
	<4CDE86C3.9080407@ru.mvista.com>
Message-ID: <AANLkTing1GK9F3rCYUn3sPjxyy0s8nNpFg7yaULn3kCh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 November 2010 12:38, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> On 12-11-2010 21:00, Catalin Marinas wrote:
>> +config ARM_LPAE
>> + ? ? ? bool "Support for the Large Physical Address Extension"
>> + ? ? ? depends on MMU&& ?CPU_V7
>> + ? ? ? help
>> + ? ? ? ? Say Y if you have an ARMv7 processor supporting the LPAE page
>> table
>> + ? ? ? ? format and you would like access memory beyond the 4GB limit.
>
> ? Maybe "like to access"?

Yes, thanks.

-- 
Catalin
