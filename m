From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Tue, 13 Oct 2015 13:57:39 +0200
Subject: [PATCH] ARM: dts: msm8974: fix typo in "disabled" property
In-Reply-To: <5733924.HXWPKe3hJM@wuerfel>
References: <1444735998-18479-1-git-send-email-michael.opdenacker@free-electrons.com>
 <5733924.HXWPKe3hJM@wuerfel>
Message-ID: <561CF1B3.2010405@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 10/13/2015 01:41 PM, Arnd Bergmann wrote:
> On Tuesday 13 October 2015 13:33:18 Michael Opdenacker wrote:
>> Replace "disable" by "disabled" in the Qualcomm MSM8974 dtsi
>>
>> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
>> ---
>>  arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> The patch looks good, but I think you are missing some people on
> Cc. Please send this to all the qcom maintainers. I suspect you
> only have Kumar on Cc because he is listed as maintainer for dts
> files in general, but platforms specific ones should go through
> the platform maintainer trees.

This sounds good. Thanks for the advise and for the quick review. I'm
resending right away...

Michael.

-- 
Michael Opdenacker, CEO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
+33 484 258 098
