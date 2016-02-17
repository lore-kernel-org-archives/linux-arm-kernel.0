From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 16 Feb 2016 17:16:04 -0800
Subject: [PATCH 4/4] arm64: cputype info for Broadcom Vulcan
In-Reply-To: <20160215101235.GA1748@arm.com>
References: <1455389195-31870-1-git-send-email-jchandra@broadcom.com>
 <1455389195-31870-5-git-send-email-jchandra@broadcom.com>
 <20160215101235.GA1748@arm.com>
Message-ID: <56C3C9D4.4020506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/02/16 02:12, Will Deacon wrote:
> On Sun, Feb 14, 2016 at 12:16:35AM +0530, Jayachandran C wrote:
>> Add Broadcom Vulcan implementor ID and part ID in cputype.h. This is
>> to document the values.
>>
>> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
>> ---
>>  arch/arm64/include/asm/cputype.h | 2 ++
>>  1 file changed, 2 insertions(+)
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Would this be picked by Calatin, or should this be sent along with the
ARM/ARM64 SoC changes pull requests (just wondering?), thanks!
-- 
Florian
