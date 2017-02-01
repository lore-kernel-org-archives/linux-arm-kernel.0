From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 1 Feb 2017 19:22:21 +0100
Subject: [PATCH] Documentation: devicetree: meson-ir: "linux, rc-map-name"
 is supported
In-Reply-To: <20170201174726.2vyvxpnie7qclrvk@rob-hp-laptop>
References: <20170131212112.5582-1-martin.blumenstingl@googlemail.com>
 <20170201174726.2vyvxpnie7qclrvk@rob-hp-laptop>
Message-ID: <29c4bd35-8723-55fe-2467-2c17d2f75b15@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 01.02.2017 um 18:47 schrieb Rob Herring:
> On Tue, Jan 31, 2017 at 10:21:12PM +0100, Martin Blumenstingl wrote:
>> The driver already parses the "linux,rc-map-name" property. Add this
>> information to the documentation so .dts maintainers don't have to look
>> it up in the source-code.
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>>  Documentation/devicetree/bindings/media/meson-ir.txt | 3 +++
>>  1 file changed, 3 insertions(+)
> 
> Acked-by: Rob Herring <robh@kernel.org>

Note that the subject has a space in the property name that should be
dropped before applying.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
