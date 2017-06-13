From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Tue, 13 Jun 2017 13:32:19 -0700
Subject: [PATCH] dt-bindings: Drop k2g genpd device ID macros
In-Reply-To: <ca91000a-627b-a655-4304-b64b78bbcf9a@ti.com>
References: <20170522183737.24946-1-d-gerlach@ti.com>
 <20170531162850.mf6giowmxj5vetxq@rob-hp-laptop>
 <ca91000a-627b-a655-4304-b64b78bbcf9a@ti.com>
Message-ID: <fc503960-d225-895c-c993-974ba6c5a92d@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/13/2017 1:16 PM, Dave Gerlach wrote:
> Santosh,
> On 05/31/2017 11:28 AM, Rob Herring wrote:
>> On Mon, May 22, 2017 at 01:37:37PM -0500, Dave Gerlach wrote:
[...]

>>> [1] https://www.spinics.net/lists/arm-kernel/msg577079.html
>>>
>>>   .../devicetree/bindings/soc/ti/sci-pm-domain.txt   |  5 +-
>>>   include/dt-bindings/genpd/k2g.h                    | 90 ----------------------
>>>   2 files changed, 3 insertions(+), 92 deletions(-)
>>>   delete mode 100644 include/dt-bindings/genpd/k2g.h
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>>
> 
> Gentle ping on this. If you're OK with the patch any chance you can pick it up?
> 
Sorry Dave I missed to pick this one in pull request for 4.13. Will pick 
this
one along with what Suman and Tero have been working for following merge
window. Thanks for reminding about this one.

Regards,
Santosh
