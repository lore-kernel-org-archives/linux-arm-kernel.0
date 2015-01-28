From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 28 Jan 2015 10:01:27 +0900
Subject: [PATCH v10 0/7] devfreq: Add devfreq-event class to provide raw
 data for devfreq device
In-Reply-To: <2091672023.141961422352757659.JavaMail.weblogic@epmlwas08c>
References: <2091672023.141961422352757659.JavaMail.weblogic@epmlwas08c>
Message-ID: <54C834E7.8060203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin,

Could you please pick remaining patches (patch4-patch7)?

On 01/27/2015 06:59 PM, MyungJoo Ham wrote:
>>  This patchset add new devfreq_event class to provide raw data to determine
>> current utilization of device  which is used for devfreq governor.
>>
>> The following description explains the feature of two kind of devfreq class:
>> - devfreq class (existing)
>>  : devfreq consumer device use raw data from devfreq_event device for
>>    determining proper current system state and change voltage/frequency
>>    dynamically using various governors.
>> - devfreq_event class (new)
>>  : Provide measured raw data to devfreq device for governor
> 
> Merged in my local git repo (1/7 to 3/7 as those three are in /drivers/devfreq).
> 
> However, the admin requires me to setup the firewall again, so please wait
> another day for the merged patches to show up in external network
> (git.kernel.org) and to make a pull-request for Rafael.
> (waiting firewall execption approvals from the admin)

Dear Myungjoo,

Thanks for your apply.

Best Regards,
Chanwoo Choi
