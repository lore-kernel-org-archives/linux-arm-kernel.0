From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Feb 2017 17:49:18 +0100
Subject: [GIT PULL 4/4] arm64: dts: exynos: DT64 for v4.11, third round
In-Reply-To: <20170214165229.y3udmy7w5gm27tys@kozik-lap>
References: <20170202183008.23500-1-krzk@kernel.org>
 <20170202183008.23500-5-krzk@kernel.org>
 <2382634.UqDUkYPZrI@wuerfel>
 <CGME20170209185703epcas3p181b744c7022b24d383bdce8409ece2ec@epcas3p1.samsung.com>
 <20170209185654.yxmubj3r4gjxcfm6@kozik-lap>
 <8a236294-a561-a857-403e-3a3a794b31f3@samsung.com>
 <20170214165229.y3udmy7w5gm27tys@kozik-lap>
Message-ID: <CAK8P3a1Q=6V07ORhEkA3MDd9OwRw4BHu91-uYyFd8MgLvggSig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 5:52 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Fri, Feb 10, 2017 at 12:30:48PM +0100, Sylwester Nawrocki wrote:
>> On 02/09/2017 07:56 PM, Krzysztof Kozlowski wrote:
>> > On Thu, Feb 09, 2017 at 04:19:57PM +0100, Arnd Bergmann wrote:
>>
>> > 2. Update of frequency (used in DTS as assigned clock rate) - this
>> >    is strictly source file change and we need it.
>> >
>> > Overall, rework would not be trivial and it would involve Sylwester.
>> > I think it is better to stay with this as is. I will remember the policy
>> > for future dependencies.
>>
>> The clk changes are already pulled into clk tree, we would get conflicts
>> with commits that are already in the clock tree if the branch is reworked
>> now.  This might not be a big issue but bisection would be broken for sure.
>>
>> I'll also try to keep in future include/dt-bindings changes separate.
>
> Arnd,
>
> Any further comments? Are you going to pull it in?

Sorry, I haven't had a chance to discuss with Olof how we want to proceed.
I've pulled it into a next/late branch for now, which is similar to what we
did in the past, and we may or may not send it after the other pull
requests.

There is one other platform that has a similar problem and I'll pull that
in the same branch, while all the others have been able to rework their
trees to avoid it for 4.11.

      Arnd
