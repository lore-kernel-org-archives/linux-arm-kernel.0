From: rdunlap@infradead.org (Randy Dunlap)
Date: Mon, 23 May 2016 07:50:13 -0700
Subject: [PATCH 0015/1529] Fix typo
In-Reply-To: <20160523090301.3cdbd523@ipc1.ka-ro>
References: <20160521113722.32053-1-andrea.gelmini@gelma.net>
 <20160523090301.3cdbd523@ipc1.ka-ro>
Message-ID: <574318A5.5000108@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/16 00:03, Lothar Wa?mann wrote:
> Hi,
> 
> On Sat, 21 May 2016 13:37:22 +0200 Andrea Gelmini wrote:
>> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
>> ---
>>  Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>> index 3e36c1d..616428a 100644
>> --- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>> +++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>> @@ -8,7 +8,7 @@ use to analyze system performance, to make behaviors visible and to count
>>  usages of each IP (DMC, CPU, RIGHTBUS, LEFTBUS, CAM interface, LCD, G3D, MFC).
>>  The Exynos PPMU driver uses the devfreq-event class to provide event data
>>  to various devfreq devices. The devfreq devices would use the event data when
>> -derterming the current state of each IP.
>> +determing the current state of each IP.
>>  
> s/determing/determine/

determining


-- 
~Randy
