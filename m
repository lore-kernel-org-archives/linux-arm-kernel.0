From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 15 Sep 2015 19:36:11 +0530
Subject: [PATCH-v2 0/3] mmc: sdhci-pxav3: Fix tabbing issue
In-Reply-To: <CAPDyKFov6uADy_o944hZS9es6hkr4WM9EV1t9MXe94TcwEHuwQ@mail.gmail.com>
References: <1441625471-16315-1-git-send-email-vaibhav.hiremath@linaro.org>
 <CAPDyKFov6uADy_o944hZS9es6hkr4WM9EV1t9MXe94TcwEHuwQ@mail.gmail.com>
Message-ID: <55F825D3.9070501@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 15 September 2015 05:58 PM, Ulf Hansson wrote:
> On 7 September 2015 at 13:31, Vaibhav Hiremath
> <vaibhav.hiremath@linaro.org> wrote:
>> Trivial patch-series, which fixes the tabbing issue in the driver,
>> uses the BIT macro for bit fields and prints notice on -EPROBE_DEFER
>> in sdhci_add_host() function on regulator unavailability.
>>
>> V1 => V2
>> ========
>>   - Fixed all comments from Joe, mostly alignment changes
>>   - Separated BIT macro usage patch into new one.
>>   - changed error to kernel notice for EPROBE_DEFER in sdhci_add_host()
>>
>> Note: This patch-series should get merged before another series -
>>
>> [PATCH-v2 0/7] mmc: sdhci-pxav3: Enable support for PXA1928 SDCHI controller
>>
>> Vaibhav Hiremath (3):
>>    mmc: sdhci-pxav3: Fix tabbing issue
>>    mmc: sdhci-pxav3: Use BIT macro for bit field definitions
>>    mmc: sdhci: print notice on -EPROBE_DEFER in sdhci_add_host() fn
>>
>>   drivers/mmc/host/sdhci-pxav3.c | 46 +++++++++++++++++++++---------------------
>>   drivers/mmc/host/sdhci.c       |  5 ++++-
>>   2 files changed, 27 insertions(+), 24 deletions(-)
>>
>> --
>> 1.9.1
>>
>
> Hi Vaibhav,
>
> FYI, I won't be picking up any of these patches. Primarily because I
> don't think they improves the code and other people also seems to
> agree to that.
>
> Regarding patch1 and similar patches which deals with only fixing
> checkpatch warnings/errors. In most cases I don't like such changes,
> as they makes it harder to use "git blame" when you want to find out
> which commit that introduced a change.
>


Honestly, I also agree with you.
But recently I have been told to do these changed to get my
main/feature changes accepted :)

No issues, I am OK to drop them.
These are just beautification changes and as you rightly
said it makes 'git blame' difficult to find original change commit.


Thanks,
Vaibhav
