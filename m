From: mikko.perttunen@kapsi.fi (Mikko Perttunen)
Date: Thu, 05 Mar 2015 12:15:10 +0200
Subject: [PATCH v8 15/18] cpufreq: Add cpufreq driver for Tegra124
In-Reply-To: <54F6B03F.8080703@iki.fi>
References: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>	
 <1425213881-5262-16-git-send-email-mikko.perttunen@kapsi.fi>
 <1425286186.24292.76.camel@x220> <54F59C16.2010401@kapsi.fi>
 <54F6B03F.8080703@iki.fi>
Message-ID: <54F82CAE.7070300@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2015 09:11 AM, Tuomas Tynkkynen wrote:
> On 03/03/2015 01:33 PM, Mikko Perttunen wrote:
>> On 03/02/2015 10:49 AM, Paul Bolle wrote:
>>> On Sun, 2015-03-01 at 14:44 +0200, Mikko Perttunen wrote:
>>>
>>> [...]
>>>
>>>> +static struct platform_driver tegra124_cpufreq_platdrv = {
>>>> +    .driver = {
>>>> +        .name    = "cpufreq-tegra124",
>>>> +        .owner    = THIS_MODULE,
>>>
>>> .owner will always be, in short, NULL.
>>>
>
> Which reminds me: recently there have been cleanups that remove the
> .owner field assignments (e.g. 30f51f248c1d "cpufreq: drop owner
> assignment from platform_drivers"), so it can be removed from here as well.
>
>
>>
>> Well noticed! I changed the config symbol to be tristate.
>>
>> Thanks,
>> Mikko Perttunen
>>

Yep, will remove.

Mikko
