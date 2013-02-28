From: javier.martin@vista-silicon.com (javier Martin)
Date: Thu, 28 Feb 2013 08:51:14 +0100
Subject: [PATCH v2 3/3] crypto: sahara: Add device tree binding for
 SAHARA2.
In-Reply-To: <20130227200530.GN1906@pengutronix.de>
References: <1361961711-4603-1-git-send-email-javier.martin@vista-silicon.com>
 <1361961711-4603-4-git-send-email-javier.martin@vista-silicon.com>
 <20130227200530.GN1906@pengutronix.de>
Message-ID: <CACKLOr3h8vNbZCV8HgL2EHtYxLPH+xmueM=JQa4MdRwDbSmiwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 February 2013 21:05, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Hi Javier,
>
> On Wed, Feb 27, 2013 at 11:41:51AM +0100, Javier Martin wrote:
>>
>> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
>> ---
>>  .../devicetree/bindings/crypto/fsl-imx-sahara.txt  |   14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/crypto/fsl-imx-sahara.txt
>>
>> diff --git a/Documentation/devicetree/bindings/crypto/fsl-imx-sahara.txt b/Documentation/devicetree/bindings/crypto/fsl-imx-sahara.txt
>> new file mode 100644
>> index 0000000..44abf11
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/crypto/fsl-imx-sahara.txt
>> @@ -0,0 +1,14 @@
>> +* Freescale i.MX SAHARA Cryptographic Accelerator
>> +
>> +Required properties:
>> +- compatible : Should be "fsl,<soc>-sahara"
>
> Please add explicitly which SoCs are supported.
>
> You can fold this patch into the driver patch. This way people reading
> the commit history have a direct cross link between the driver and the
> documentation.

OK Sascha. Thanks.

As we discussed previously it seems only i.MX27 is supported right now.


-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
