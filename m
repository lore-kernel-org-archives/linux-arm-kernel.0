From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 08 May 2014 23:37:58 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Ml0gQVJNOiBkdHM6IGlteDY6IGFkZCBuZXcgYm9hcmQg?=
 =?UTF-8?B?UklvVGJvYXJk?=
In-Reply-To: <536BDABB.7090101@gmail.com>
References: <53695C34.5000604@gmail.com> <1399570376.88508577@f371.i.mail.ru>
 <536BDABB.7090101@gmail.com>
Message-ID: <1399577878.472924335@f261.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thu, 08 May 2014 20:27:55 +0100 ?? Iain Paton <ipaton0@gmail.com>:
> On 08/05/14 18:32, Alexander Shiyan wrote:
> > Thu, 08 May 2014 18:12:02 +0100 ?? Iain Paton <ipaton0@gmail.com>:
> >> +&aips2 {
> >> +        i2c4: i2c at 021f8000 {
> >> +                #address-cells = <1>;
> >> +                #size-cells = <0>;
> >> +                compatible = "fsl,imx1-i2c";
> > 
> > Are you sure about use "fsl,imx1-i2c" instead of  "fsl,imx21-i2c"?
> > In any case you should add "fsl-imx6dl-i2c" as first compatible string.
> > The rest looks good.
> 
> Sure?  No.  However that's what currently exists in imx6dl.dtsi for i2c4.
> 
> looking at the other i2c interfaces in imx6qdl.dtsi, they're using
> fsl,imx6q-i2c as the first compatible string. So I think I should use
> either fsl,imx6dl-i2c or fsl,imx6q-i2c. 
> What's the difference between that and your suggested fsl-imx6dl-i2c?
> If we assume can assume the i2c4 block is functionally identical to
> i2c[123] then shouldn't I use an identical compatible string?

Yes. This is just my typo. If all I2C-interfaces is identical in the datasheet,
the same compatible string (fsl,imx6q-i2c) should be used.

---
