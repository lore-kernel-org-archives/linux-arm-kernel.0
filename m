From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 07 Apr 2015 17:43:33 +0100
Subject: [GIT PULL] arm-cci PMU updates for 4.1
In-Reply-To: <20150403204016.GB23023@localhost>
References: <20150327172500.GO1562@arm.com> <20150403204016.GB23023@localhost>
Message-ID: <55240935.9060900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/15 21:40, Olof Johansson wrote:
> On Fri, Mar 27, 2015 at 05:25:00PM +0000, Will Deacon wrote:
>> Hi Olof, Arnd,
>>
>> Please can you pull the following ARM CCI PMU updates for 4.1? Suzuki
>> has reworked parts of the existing driver so that it can be used on CPUs
>> booting in non-secure mode (i.e. ARM64 systems) and also make it easier
>> to port over to new IP, such as CCI-500.
>>
>> It's coming via me as $ARM_PERF_GUY, but Nico has Acked the core driver
>> (non-PMU) changes. Note that these have been in next for a bit, but I
>> can drop the branch once you've pulled.
>>
>> Cheers,
>>
>> Will
>>
>> --->8
>>
>> The following changes since commit 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda:
>>
>>    Linux 4.0-rc4 (2015-03-15 17:38:20 -0700)
>>
>> are available in the git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-perf-4.1
>>
>> for you to fetch changes up to 874c571414d5617f4042298986b6a826816ee885:
>>
>>    arm-cci: Fix CCI PMU event validation (2015-03-27 13:45:02 +0000)
>
> Merged now. The Kconfig merge was a bit messy since someone decided to sort the
> file, and Stephen will see that too (cc:d here).
>
Tested the CCI PMU on the for-next branch, works well. Thanks Olof.

Suzuki
