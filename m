Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECEAC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:49:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A8F20673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OWx3G+cQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A8F20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9iw3FHaRuyXRw7k1H2Vkpd19+v9oZ/jHKJSA+v1eRII=; b=OWx3G+cQGfvxYFrkPOCD5Gd5h
	GM17x7NunSYB55QnZmXjyTTg9K/kv/YHvpLxe6xZjAiJRPxFQBpq4Rj2hAY3NJR5QNH0goEpoImWr
	ClQGS7Iz+8VgaSyXpOONjrmvdfqxGP6iAZBPoTPKdNr1DpRX7xmA8rTWTeD6RxofidMIIiRIGg1z2
	Wj7T6fnJhOqrDvWAKGYHWeNQQsd8o0X2mdpcA7RJG6M1gEq7v+qsxG1OUyApkKbDQ1H9M51G3frfx
	EFAcBfB6VjPA3+VakGMHBQpVSH2jCACFKRgFm75vFQisnXQQfgJdVPKAytkRG0iRWPl9HuHbp+9nJ
	ai5ugPoGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSmv7-0006RM-Lp; Fri, 30 Nov 2018 17:49:41 +0000
Received: from mail.bugwerft.de ([46.23.86.59])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSmv4-0006QM-FC
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:49:39 +0000
Received: from [192.168.178.170] (pD95EF9A6.dip0.t-ipconnect.de
 [217.94.249.166])
 by mail.bugwerft.de (Postfix) with ESMTPSA id CC6932C4586;
 Fri, 30 Nov 2018 17:49:07 +0000 (UTC)
Subject: Re: [PATCH] ARM: dts: pxa3xx: Add Raumfeld DTS files
To: Rob Herring <robh+dt@kernel.org>
References: <20181105194040.25406-1-daniel@zonque.org>
 <CAL_JsqJ9_nUu_iNOn7Eu91tcGO1xqFv-fYn4zEjLGim+kK4tXQ@mail.gmail.com>
From: Daniel Mack <daniel@zonque.org>
Message-ID: <7aee6a27-1897-304d-4d1c-e8c31d960159@zonque.org>
Date: Fri, 30 Nov 2018 18:49:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ9_nUu_iNOn7Eu91tcGO1xqFv-fYn4zEjLGim+kK4tXQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_094938_649983_25AB551C 
X-CRM114-Status: GOOD (  15.94  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob,

Thanks a lot for the review!

On 30/11/2018 3:51 PM, Rob Herring wrote:
> On Mon, Nov 5, 2018 at 1:41 PM Daniel Mack <daniel@zonque.org> wrote:

>> +               compatible = "spi-gpio";
>> +               #address-cells = <0x1>;
>> +               #size-cells = <0>;
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&spi_pins>;
>> +               gpio-sck = <&gpio 95 GPIO_ACTIVE_HIGH>;
>> +               gpio-miso = <&gpio 98 GPIO_ACTIVE_HIGH>;
>> +               gpio-mosi = <&gpio 97 GPIO_ACTIVE_HIGH>;
>> +               cs-gpios = <
>> +                       &gpio 34 GPIO_ACTIVE_HIGH
>> +                       &gpio 125 GPIO_ACTIVE_HIGH
>> +                       &gpio 96 GPIO_ACTIVE_HIGH
>> +               >;
>> +               num-chipselects = <3>;
> 
> Why do we have this when we can just get the length of cs-gpios?

That's a good question, but for now, the driver requires the node to be 
there. It can probably be cleaned up by a separate series.

>> +&pwri2c {
>> +       status = "okay";
>> +
>> +       max8660: regulator@34 {
>> +               compatible = "maxim,max8660";
>> +               reg = <0x34>;
>> +
>> +               regulators {
>> +                       regulator@0 {
> 
> Drop the unit-address as there is no reg property. Build your DT with
> W=12 and fix any new warnings these new files add (probably some are
> from the SoC dtsi).

This hint helped a lot. I've fixed numerous smaller problems in the SoC 
dtsi and will submit them together with a v2 of this patch.


Best regards,
Daniel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
