From: gcembed@gmail.com (=?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?=)
Date: Tue, 19 Feb 2013 20:57:50 +0100
Subject: coda: support of decoding
In-Reply-To: <20130219184749.GD30071@pengutronix.de>
References: <5122D999.3070405@gmail.com>
 <20130219184749.GD30071@pengutronix.de>
Message-ID: <5123D93E.9050602@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
On 02/19/2013 07:47 PM, Robert Schwebel wrote:
> On Tue, Feb 19, 2013 at 02:47:05AM +0100, Ga?tan Carlier wrote:
>> I see in code source of coda driver that decoding is not supported.
>>
>> ctx->inst_type = CODA_INST_DECODER;
>> v4l2_err(v4l2_dev, "decoding not supported.\n");
>> return -EINVAL;
>>
>> Is there any technical reason or the code has not been written ?
>
> We have a lot of encoder + decoder patches for Coda in the queue, but
> unfortunately not all of that is ready-for-primetime yet.
MX27. I have not yet tested if encoding is working or not.
Where can I find this set of patches ? I will test it with pleasure.
>
> Which processor are you interested in? MX27 or MX5/MX6?
>
> rsc
>
Thank you.
Best regards,
Ga?tan Carlier.
