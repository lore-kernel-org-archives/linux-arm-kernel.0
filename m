From: j-keerthy@ti.com (Keerthy)
Date: Fri, 4 Aug 2017 09:46:13 +0530
Subject: [PATCH v3 1/2] gpio: davinci: Add keystone-k2g compatible
In-Reply-To: <20170803161748.u7ier3kt3xmm25jw@rob-hp-laptop>
References: <1501051524-5990-1-git-send-email-j-keerthy@ti.com>
 <20170803161748.u7ier3kt3xmm25jw@rob-hp-laptop>
Message-ID: <af4f6eda-9a91-2ed4-ed34-1fa4e90f0d7c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 03 August 2017 09:47 PM, Rob Herring wrote:
> On Wed, Jul 26, 2017 at 12:15:23PM +0530, Keerthy wrote:
>> The patch adds keystone-k2g compatible, specific properties and
>> an example.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>
>> Changes in v3:
>>
>>   * Added details about family of SoCs corresponding to compatibles.
>>
>>  .../devicetree/bindings/gpio/gpio-davinci.txt      | 40 +++++++++++++++++++++-
>>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks Rob.

Santosh,

I will post a v4 adding Rob's and Linus's Ack.

Thanks,
Keerthy

> 
