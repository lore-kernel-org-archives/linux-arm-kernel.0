From: smoch@web.de (=?windows-1252?Q?S=F6ren_Moch?=)
Date: Tue, 21 Oct 2014 13:57:46 +0200
Subject: [PATCH] arm: dts: add initial support for TBS2910 Matrix ARM
 mini PC
In-Reply-To: <54460DD5.5010908@gmail.com>
References: <1413635236-3825-1-git-send-email-smoch@web.de>
 <54460DD5.5010908@gmail.com>
Message-ID: <54464A3A.2070003@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

Thanks for your review.

>> +/ {
>> +    model = "TBS2910 Matrix ARM mini PC";
>> +    compatible = "tbs,imx6q-tbs2910", "fsl,imx6q";
>
> [...]
> Also, board compatible should only be "tbs,tbs2910".

Similar boards use e.g.
	compatible = "fsl,imx6q-sabresd", "fsl,imx6q";
	compatible = "udoo,imx6q-udoo", "fsl,imx6q";
	compatible = "wand,imx6q-wandboard", "fsl,imx6q";

So is it really better to use only "tbs,tbs2910" here?

Soeren
