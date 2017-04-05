From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 5 Apr 2017 13:55:36 +0530
Subject: [PATCH v5 14/24] dt-bindings: mfd: syscon: Add documentation for
 #syscon-cells property
In-Reply-To: <20170331190627.nucviejokdklgtk7@rob-hp-laptop>
References: <20170327094520.3129-1-kishon@ti.com>
 <20170327094520.3129-15-kishon@ti.com>
 <20170331185852.mxa4gvjxbuxl65dq@rob-hp-laptop>
 <20170331190627.nucviejokdklgtk7@rob-hp-laptop>
Message-ID: <19ba5ea6-b12b-5b0f-dbbe-6bdba03120ac@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Saturday 01 April 2017 12:36 AM, Rob Herring wrote:
> On Fri, Mar 31, 2017 at 01:58:52PM -0500, Rob Herring wrote:
>> On Mon, Mar 27, 2017 at 03:15:10PM +0530, Kishon Vijay Abraham I wrote:
>>> Add documentation for the optional #syscon-cells property to determine
>>> the number of cells that should be given in the phandle while
>>> referencing the syscon-node.
>>>
>>> Suggested-by: Rob Herring <robh@kernel.org>
>>
>> I did? When?
>>
>> I'm not remembering why we need this. Generally, phandles to a syscon 
>> are for a single defined purpose. When do we need a list of them?
> 
> Ah, I remember now the context. I suggested using standard parsing 
> function rather than open coding. I wasn't suggesting changing the 
> binding. Instead of of_parse_phandle_with_args, can't 
> of_parse_phandle_with_fixed_args work?

yes, it can be used. Will change it my next revision.

Thanks
Kishon
