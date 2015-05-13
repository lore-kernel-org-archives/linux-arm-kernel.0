From: nm@ti.com (Nishanth Menon)
Date: Wed, 13 May 2015 10:00:41 -0500
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <20150513050559.GE28858@linux>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <554FFFA3.1060801@ti.com> <20150512051633.GB32300@linux>
 <555224A2.7000308@ti.com> <20150513050559.GE28858@linux>
Message-ID: <55536719.5050208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2015 12:05 AM, Viresh Kumar wrote:
> On 12-05-15, 11:04, Nishanth Menon wrote:
>> Just curious -> is'nt it better to just have min<->max range? binding
>> as it stands right now is open to interpretation as to what will be
>> attempted and in what sequence? with a valid min, target or max -
>> is'nt it more power efficient always to go for a "min" than a target?
>>
>> Further, min<->max implies anywhere in that range and is more
>> consistent with "regulator like" description.
> 
> It came out after some discussions on the list, you may want to go
> through that.
> 
> https://lists.linaro.org/pipermail/linaro-kernel/2015-January/019844.html

I see the thread saying that voltage-tolerance is a crappy idea -> I
agree to that.

What I dont see in the thread, and the point I raised here, why have
nominal/typical voltage at all? min<->max should be sufficient,
correct? If the device cannot function at min, then it should not be
documented as part of valid range at all.


-- 
Regards,
Nishanth Menon
