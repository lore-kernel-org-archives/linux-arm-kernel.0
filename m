From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 23 Aug 2016 10:20:28 +0200
Subject: [PATCH 05/13] scpi: move of_match table before probe functions
In-Reply-To: <def54975-8014-a326-6f82-8953740e520c@arm.com>
References: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
 <1471515066-3626-6-git-send-email-narmstrong@baylibre.com>
 <def54975-8014-a326-6f82-8953740e520c@arm.com>
Message-ID: <833d9cf4-9eca-a8b5-96d5-5ccab159929e@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2016 06:24 PM, Sudeep Holla wrote:
> 
> 
> On 18/08/16 11:10, Neil Armstrong wrote:
>> Move the of_match table to prapre adding new compatible strings, with
>> match data in order to be used by the probe function.
>>
> 
> I understand the need of this change, but can be part of the patch
> introducing the need for this.
> 

Yes, but I did not want to pollute the next patch, I'll merge them for v2.

Neil
