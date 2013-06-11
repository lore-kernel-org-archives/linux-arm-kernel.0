From: csd@broadcom.com (Christian Daudt)
Date: Tue, 11 Jun 2013 09:56:45 -0700
Subject: [PATCH 0/2] ARM dts: bcm281xx: use preprocessor for device trees
In-Reply-To: <20130611070344.GF6688@quad.lixom.net>
References: <1370497295-12682-1-git-send-email-matt.porter@linaro.org>
 <20130611070344.GF6688@quad.lixom.net>
Message-ID: <51B756CD.1070500@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-06-11 12:03 AM, Olof Johansson wrote:
> On Thu, Jun 06, 2013 at 01:41:33AM -0400, Matt Porter wrote:
>> This series follows the same approach as taken on Tegra and
>> OMAP DT files to use the C preprocessor in order to improve
>> readability. Since bcm281xx does not yet have gpio and pinctrl
>> support, this series just enables the C preprocessor and removes
>> the magic constants from existing irq properties. Any new
>> additions can come in using human readable definitions.
>>
>> The resulting dtb was diff-tested to validate it versus the non
>> preprocessed dts version.
>>
>> Matt Porter (2):
>>    ARM: dts: bcm281xx: use #include for device tree files
>>    ARM: dts: bcm281xx: use existing defines for irqs
> Acked-by: Olof Johansson <olof@lixom.net>
Acked-by: Christian Daudt <csd@broadcom.com>
>
> Not sure what else you'll have for 3.11 devicetree-wise, Christian -- your
> choice if you want to send a pull request or ack these and we'll apply them
> directly.
>
I can add them to my tree. I already have a pending dt commit to push.

  thanks,
    csd
