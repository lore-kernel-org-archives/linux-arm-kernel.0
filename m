From: christianshewitt@gmail.com (Christian Hewitt)
Date: Fri, 9 Nov 2018 13:44:01 -0500
Subject: [PATCH v3 1/3] dt-bindings: Add vendor prefix for Smartlabs LLC
In-Reply-To: <ae4a4f99-eecc-7a71-5007-d171449c8619@suse.de>
References: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
 <1541706240-30036-1-git-send-email-christianshewitt@gmail.com>
 <1541706240-30036-2-git-send-email-christianshewitt@gmail.com>
 <ae4a4f99-eecc-7a71-5007-d171449c8619@suse.de>
Message-ID: <5327F4D2-7348-4D5F-A077-D66D4ACB7553@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 Nov 2018, at 1:29 pm, Andreas F?rber <afaerber@suse.de> wrote:
> 
>> Smartlabs LLC are a professional integrator of Interactive TV solutions
>> and IPTV/VOD devices (https://www.smartlabs.tv/en/about/).
>> 
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>> Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>> 1 file changed, 1 insertion(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index 4b1a2a8..c424fe0 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -357,6 +357,7 @@ sirf	SiRF Technology, Inc.
>> sis	Silicon Integrated Systems Corp.
>> sitronix	Sitronix Technology Corporation
>> skyworks	Skyworks Solutions, Inc.
>> +smartlabs	Smartlabs LLC
> 
> You added the LLC but did not upper-case the L - intentional?

Not intentional. I?ll correct this (and another mention in the dts) in v4.

Christian
