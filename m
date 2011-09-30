From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 30 Sep 2011 13:53:10 +0200
Subject: [PATCH 02/13] gpio/omap: Adapt GPIO driver to DT
In-Reply-To: <4E8161C7.7020404@ti.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
	<1317055821-20652-3-git-send-email-b-cousson@ti.com>
	<4E8161C7.7020404@ti.com>
Message-ID: <4E85ADA6.2000001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Second thought... I was too fast to say OK :-)

On 9/27/2011 7:40 AM, Nayak, Rajendra wrote:
> On Monday 26 September 2011 10:20 PM, Benoit Cousson wrote:

[...]

>> +	if (match) {
>> +		of_property_read_u32(node, "bank-width",&bank->width);
>
> Bank width should be u32.

I guess you meant bank->width, and it appears that bank->width is 
already a u32.

Regards,
Benoit
