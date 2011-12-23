From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 23 Dec 2011 15:07:13 +0530
Subject: [QUESTION] How to set static/dynamic dependency between clock
 domains
In-Reply-To: <4EF44363.4050008@ti.com>
References: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
 <CACVXFVPOaw7OG7owJw0h7DAe3pRH6nROsy13UeAWPWgLedKY1g@mail.gmail.com>
 <CAMQu2gwDth6OVTk3PkRCo05QF6WeQvMTJ-d5s33cT35GSVwT=w@mail.gmail.com>
 <CACVXFVNtaaxB-MRXKBgAZFEkf72nsgcOSHOFsYjspoL0Fv6VWA@mail.gmail.com>
 <CAMQu2gzs6op9C8jDJ5xEGs7A7ok_GXeD5OxnHiDoeHaKghCJ5g@mail.gmail.com>
 <CACVXFVOOQVe8u5TFZDYrNqvga-=RJ1mueaaqkBNB-s4BwkhiOw@mail.gmail.com>
 <CAMQu2gwKgpH_dOBQovgxBR_yTGAiXu=2yPhwgoERv+YD+pO_Sg@mail.gmail.com>
 <4EF44363.4050008@ti.com>
Message-ID: <CAMQu2gwhyZasccr8wU6srhb8Y+T02yawy+RQQMzUGZjy1bvtJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 23, 2011 at 2:31 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> Hi Santosh,
>
>
> On 12/23/2011 9:45 AM, Shilimkar, Santosh wrote:
>>
>> On Fri, Dec 23, 2011 at 2:00 PM, Ming Lei<tom.leiming@gmail.com> ?wrote:
>
>
> [...]
>
>
>>> The only change on iss(CAM) clock domain setting in your commit[1] is to
>>> configure CLKTRCTRL as HW_AUTO, instead of previous ?SW_WKUP.
>>> Once I change flags of iss to CLKDM_CAN_SWSUP [2], the issue can be
>>> fixed, so I am wondering if something is wrong about HW_AUTO mode
>>> of CAM clock domain.
>>>
>> Now I recollect the issue and also track a patch in the internal product
>> tree.
>> Same is attached and also in the end of the email.
>>
>> I am lopping Miguel who wrote the patch and Benoit who acked it.
>> This should sort out your issue as you have already verified it works.
>
>
> Ooops, that remains me that I forgot to push it upstream:-(
>
> Since this is a bug fix, if this is too late for 3.3, we can try to push it
> during rc phases.
>
Cool. Thanks for picking it up

Regards
Santosh
