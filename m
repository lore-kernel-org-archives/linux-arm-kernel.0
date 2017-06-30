From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 30 Jun 2017 11:24:03 +0100
Subject: [PATCH 1/9] Documentation: dt-bindings: add support for mailbox
 client shared memory
In-Reply-To: <20170628225633.rvfwc4s6rfqwo2jb@rob-hp-laptop>
References: <1498492513-29771-1-git-send-email-sudeep.holla@arm.com>
 <1498492513-29771-2-git-send-email-sudeep.holla@arm.com>
 <20170628225633.rvfwc4s6rfqwo2jb@rob-hp-laptop>
Message-ID: <6ca6f182-ca0d-2f89-690c-ed0041ccb498@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/06/17 23:56, Rob Herring wrote:
> On Mon, Jun 26, 2017 at 04:55:05PM +0100, Sudeep Holla wrote:
>> Many users of the mailbox controllers depend on the shared memory between the
>> two end points to exchange the main data while using simple doorbell mechanism
>> to alert the end points of the presence of a message.
> 
> "dt-bindings: mailbox: ..." for the subject.
> 

Fixed locally now.

>>
>> This patch defines device tree bindings to represent such shared memory in a
>> generic way.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  .../devicetree/bindings/mailbox/mailbox.txt        | 28 ++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
> 
> Otherwise,
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

Thanks

-- 
Regards,
Sudeep
