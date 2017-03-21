From: mylene.josserand@free-electrons.com (Mylene Josserand)
Date: Tue, 21 Mar 2017 08:42:24 +0100
Subject: [PATCH v3 1/5] ASoC: sun8i-codec: Remove analog "HP" widget
In-Reply-To: <20170320173903.fc2m4euobea3npyq@sirena.org.uk>
References: <20170318075509.3836-1-mylene.josserand@free-electrons.com>
 <20170318075509.3836-2-mylene.josserand@free-electrons.com>
 <20170320173903.fc2m4euobea3npyq@sirena.org.uk>
Message-ID: <27e4866f-5b08-76df-2cb0-87302da39ec7@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 20/03/2017 18:39, Mark Brown wrote:
> On Sat, Mar 18, 2017 at 08:55:05AM +0100, Myl?ne Josserand wrote:
>> The "HP" widget is already present and take part to
>> the analog part (sun8i-codec-analog).
>>
>> Remove it from the digital part as it is unnecessary.
>
> I know I said to send against Linus' tree but it turns out this actually
> conflicts with some of the existing fixes, please see my fixes/sunxi
> branch and resend against that.  Sorry for the hassle here.
>

Sure, no problem! I will rebase my V4 on your fixes/sunxi branch.

Best regards,

-- 
Myl?ne Josserand, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
