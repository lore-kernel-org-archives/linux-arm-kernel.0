From: scott.branden@broadcom.com (Scott Branden)
Date: Mon, 4 Jun 2018 14:30:47 -0700
Subject: [PATCH] arm64: dts: stingray: Add otp device node
In-Reply-To: <c9219029-6e45-1889-6326-470d2bc9e46c@gmail.com>
References: <1527106630-4760-1-git-send-email-scott.branden@broadcom.com>
 <c9219029-6e45-1889-6326-470d2bc9e46c@gmail.com>
Message-ID: <f6f3e76e-eac9-797d-fea5-eac64327ec7f@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,


On 18-06-04 02:24 PM, Florian Fainelli wrote:
> On 05/23/2018 01:17 PM, Scott Branden wrote:
>> Add otp device node for Stingray SOC.
>>
>> Fixes: 2fa9e9e29ea2 ("arm64: dts: Add GPIO DT nodes for Stingray SOC")
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> Applied to devicetree-arm64/next with s/otp/OTP/ and removing the Fixes
> line since that is not a bug fix AFAICT.
It fixes the issue that OTP is not active as it is missing the device node?
>
> Thank you
