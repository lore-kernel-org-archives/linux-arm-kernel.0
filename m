From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 13 May 2015 10:35:59 +0530
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <555224A2.7000308@ti.com>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <554FFFA3.1060801@ti.com> <20150512051633.GB32300@linux>
 <555224A2.7000308@ti.com>
Message-ID: <20150513050559.GE28858@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-05-15, 11:04, Nishanth Menon wrote:
> Just curious -> is'nt it better to just have min<->max range? binding
> as it stands right now is open to interpretation as to what will be
> attempted and in what sequence? with a valid min, target or max -
> is'nt it more power efficient always to go for a "min" than a target?
> 
> Further, min<->max implies anywhere in that range and is more
> consistent with "regulator like" description.

It came out after some discussions on the list, you may want to go
through that.

https://lists.linaro.org/pipermail/linaro-kernel/2015-January/019844.html

> True. one option might be to allow for vendor specific property
> extensions - that will let vendors add in additional quirky data
> custom to their SoCs as needed.

Yeah, I am planning to support them.

-- 
viresh
