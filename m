From: nm@ti.com (Nishanth Menon)
Date: Fri, 2 Sep 2016 12:07:37 -0500
Subject: [PATCH V2 1/5] Documentation: Add support for TI System Control
 Interface (TI-SCI) protocol
In-Reply-To: <20160902150628.GA19493@rob-hp-laptop>
References: <20160830130647.6828-1-nm@ti.com> <20160830130647.6828-2-nm@ti.com>
 <20160902150628.GA19493@rob-hp-laptop>
Message-ID: <CAGo_u6q0xxnUj5ary82OU1uP=kTHfA_3N7_d7OiSEwS1_5dXuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Fri, Sep 2, 2016 at 10:06 AM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Aug 30, 2016 at 08:06:43AM -0500, Nishanth Menon wrote:
[...]
>> +
>> +TI-SCI Client Device Node:
>> +========================
>> +
>> +Client nodes refer to the required TI-SCI device using the "ti,sci" property.
>
> As I mentioned for power domains, for clients that are self contained
> (i.e. a single function) I think the should be child nodes.
>

Thanks for the feedback. I think we should be able to do that and also
assume you have no further improvements you'd like to see here.

Looking at current Documentation/devicetree/bindings/arm/arm,scpi.txt
-> it makes sense to stick along the same lines as you mentioned.

Dave, Tero: do you guys have any objections?


---
Regards,
Nishanth Menon
