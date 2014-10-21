From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 21 Oct 2014 14:03:51 +0200
Subject: [PATCH] arm: dts: add initial support for TBS2910 Matrix ARM
 mini PC
In-Reply-To: <54464A3A.2070003@web.de>
References: <1413635236-3825-1-git-send-email-smoch@web.de>
 <54460DD5.5010908@gmail.com> <54464A3A.2070003@web.de>
Message-ID: <54464BA7.9030001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.10.2014 13:57, S?ren Moch wrote:
>>> +/ {
>>> +    model = "TBS2910 Matrix ARM mini PC";
>>> +    compatible = "tbs,imx6q-tbs2910", "fsl,imx6q";
>>
>> [...]
>> Also, board compatible should only be "tbs,tbs2910".
>
> Similar boards use e.g.
>      compatible = "fsl,imx6q-sabresd", "fsl,imx6q";
>      compatible = "udoo,imx6q-udoo", "fsl,imx6q";
>      compatible = "wand,imx6q-wandboard", "fsl,imx6q";
>
> So is it really better to use only "tbs,tbs2910" here?

Hmm, having the SoC name again in the board compatible seems
odd to me, e.g. we have "google,chromecast" without the SoC
name in it.

Anyway, it is just a compatible and if it is common for imx-
based boards or Shawn/Sascha like to have it this way you
should stick with that, of course.

Sebastian
