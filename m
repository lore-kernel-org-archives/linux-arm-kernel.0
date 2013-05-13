From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 13 May 2013 22:03:57 +0200
Subject: [PATCH] pinctrl: dove: add PMU functions to pinctrl
In-Reply-To: <20130513200002.GY31290@titan.lakedaemon.net>
References: <1367883368-27889-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130513200002.GY31290@titan.lakedaemon.net>
Message-ID: <5191472D.7060601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2013 10:00 PM, Jason Cooper wrote:
> On Tue, May 07, 2013 at 01:36:08AM +0200, Sebastian Hesselbarth wrote:
>> Dove power management unit can mux some special functions to mpp0-15.
>> This patch adds support to set/get the current PMU function mapped
>> to the corresponding mpp pins. The device tree documentation is also
>> updated accordingly.
>>
>> Signed-off-by: Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
>
> Do you intend to have anything depending on these changes in this merge
> window?

Jason,

I don't. There will be pmu and pmic support someday but I am not working
on it.

Sebastian
