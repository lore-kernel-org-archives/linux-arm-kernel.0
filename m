From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 19 Nov 2015 10:06:13 +0000
Subject: [PATCH 2/5] arm64: cpufeature: Track unsigned fields
In-Reply-To: <564D9E61.8010802@arm.com>
References: <1447866238-22970-1-git-send-email-suzuki.poulose@arm.com>
 <1447866540-23207-1-git-send-email-suzuki.poulose@arm.com>
 <1447866540-23207-2-git-send-email-suzuki.poulose@arm.com>
 <564D56CA.60502@linaro.org> <564D9E61.8010802@arm.com>
Message-ID: <564D9F15.3020508@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/11/15 10:03, Suzuki K. Poulose wrote:
> On 19/11/15 04:57, AKASHI Takahiro wrote:
>> Hi
>>
>>  From my curiosity,
>> can you please clarify your criteria regarding which fields of a register should be signed or unsigned?
>> I guessed that the fields marked with FTR_LOWER_SAFE or FTR_HIGHER_SAFE could be unsigned,

Also, the unsigned values are not restricted to LOWER_SAFE/HIGHER_SAFE, but also applies for
FTR_EXACT, so that we use the appropriate methods to extract them.


Suzuki
