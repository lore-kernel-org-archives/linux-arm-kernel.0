From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Sep 2013 17:16:11 -0600
Subject: [PATCH] ASoC: generic: Add generic DT based simple codec
In-Reply-To: <20130923232648.GL21013@sirena.org.uk>
References: <20130919105437.75e0f0a3@armhf> <5240B07C.6080404@wwwdotorg.org>
 <20130923232648.GL21013@sirena.org.uk>
Message-ID: <5244C03B.6060806@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2013 05:26 PM, Mark Brown wrote:
> On Mon, Sep 23, 2013 at 03:19:56PM -0600, Stephen Warren wrote:
>> On 09/19/2013 02:54 AM, Jean-Francois Moine wrote:
> 
>>> +Required properties: +- compatible: should be
>>> "linux,simple-codec".
> 
>> We shouldn't have any Linux-specific bindings. It might be
>> reasonable to define a binding for a "simple CODEC", but there's
>> no reason it should be Linux-specific.
> 
> What's the vendor prefix to use then?  The same thought did occur
> to me but I wasn't sure what to suggest instead.

For other non-vendor-specific/generic bindings, we've simply omitted
the vendor prefix from the compatible value, e.g.: gpio-keys,
i2c-gpio, regulator-fixed, etc.
