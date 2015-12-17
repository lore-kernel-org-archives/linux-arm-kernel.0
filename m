From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 17 Dec 2015 11:04:18 +0900
Subject: [GIT PULL 0/9] ARM: EXYNOS: Pull request for v4.5
In-Reply-To: <56721326.30004@samsung.com>
References: <1449020386-20250-1-git-send-email-k.kozlowski@samsung.com>
 <56721326.30004@samsung.com>
Message-ID: <56721822.7020608@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.12.2015 10:43, Krzysztof Kozlowski wrote:
> On 02.12.2015 10:39, Krzysztof Kozlowski wrote:
>> Hi Kukjin,
>>
>> A lot of stuff for v4.5 with 3 dependencies split into
>> separate tags. The need for dependency is explained both
>> in merge-commit and in description of a tag which is using
>> the dependency.
> 
> Hi everyone,
> 
> It's been like two weeks... we are after v4.4-rc5 and Christmas season
> is coming... there are some dependencies here and even more stuff waits
> out of queue for this pull request (moving SROM and PMU to drivers/soc,
> cpufreq for Exynos542x).
> 
> What I want to say is that I am really not sure whether further waiting
> is beneficial...
> All these patches have been boiling in linux-next for some time (through
> my tree).
> 
> 
> Are there any comments about this pull request? Ordering of branches?
> Weird looking tags? Bugs? etc.? Anything waits in your tree Kukjin?
> 
> 
> Maybe this could be pulled directly by arm-soc folks?
> 

Actually in the same time I sent this mail I got an ack from Kukjin (his
Business Trip to China extended further than planned), so:

Arnd, Kevin and Olof,
Could you pull this for v4.5 or share your comments?


The number of tags is not that scary... just some dependencies split
across 3 tags.


Best regards,
Krzysztof



> 
>>
>> The order goes like (but of course dependencies
>> could be pulled all at once at beginning):
>> 1. tags/samsung-dt-syscon-restart-4.5
>> 2. tags/samsung-soc-4.5
>> 3. tags/samsung-clk-arm64-symbols-4.5
>> 4. tags/samsung-soc64-4.5
>> 5. tags/samsung-drivers-4.5
>> 6. tags/samsung-clk-exynos4-4.5
>> 7. tags/samsung-dt-4.5
>> 8. tags/samsung-dt64-4.5
>> 9. tags/samsung-defconfig-4.5
>>
>> I split dependencies to three tags so clock or other folks could
>> easily grab them if needed.
>>
>> Please share your comments or pull as early as possible as we have here
>> some more dependencies than usual.
>>
>>
>> Kind regards,
>> Krzysztof
>>
> 
> 
