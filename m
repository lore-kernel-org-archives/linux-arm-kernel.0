From: david@lechnology.com (David Lechner)
Date: Fri, 5 Aug 2016 14:54:33 -0500
Subject: [RFC] User-defined leds
In-Reply-To: <20160805195130.GA26694@amd>
References: <57965C15.1070705@lechnology.com>
 <DB74DD94-7737-4F06-BD35-D698A65E30AD@holtmann.org>
 <20160805195130.GA26694@amd>
Message-ID: <8db4e308-ae2f-ee8a-d570-cd751c4f0269@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2016 02:51 PM, Pavel Machek wrote:
>
> Could the device tree be used to bind LED driver to otherwise unused
> gpio?
>
> 								Pavel
>

There is already a leds-gpio driver that does this.

https://www.kernel.org/doc/Documentation/devicetree/bindings/leds/leds-gpio.txt
