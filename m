From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Fri, 22 Jan 2016 17:45:23 +0100
Subject: [RFC PATCH v3] irqchip: Add support for Tango interrupt controller
In-Reply-To: <yw1x7fj1muv1.fsf@unicorn.mansr.com>
References: <569CE0F2.1060507@sigmadesigns.com>
 <569D0B80.1010908@sigmadesigns.com> <569D165E.4060004@sigmadesigns.com>
 <569FAFF5.4090909@arm.com> <yw1xr3hcqlix.fsf@unicorn.mansr.com>
 <569FB471.8000909@arm.com> <yw1xmvs0qkue.fsf@unicorn.mansr.com>
 <569FB7A9.9080309@sigmadesigns.com> <yw1xegdcqk8n.fsf@unicorn.mansr.com>
 <569FB91D.9030704@sigmadesigns.com> <yw1x1t9cqg18.fsf@unicorn.mansr.com>
 <56A2518F.6060808@sigmadesigns.com> <yw1xfuxpmv2f.fsf@unicorn.mansr.com>
 <56A25ACF.5040205@sigmadesigns.com> <yw1x7fj1muv1.fsf@unicorn.mansr.com>
Message-ID: <56A25CA3.9000001@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/01/2016 17:39, M?ns Rullg?rd wrote:

> Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:
> 
>> On 22/01/2016 17:35, M?ns Rullg?rd wrote:
>>
>>> Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:
>>>
>>>> With your latest patch, can I drop the ranges property?
>>>
>>> Why would you want to do that?
>>
>> <confused> I thought that was the whole point of the v4 improvement?
> 
> The point was to make it work right *if* someone were to do that even
> though having it there better reflects what the hardware actually looks
> like.

That's the part I'm struggling to understand. Who other than you or me
would write a device tree from scratch for this interrupt controller?
