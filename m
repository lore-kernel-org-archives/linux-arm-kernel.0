From: scott.branden@broadcom.com (Scott Branden)
Date: Mon, 4 Jun 2018 15:33:55 -0700
Subject: [PATCH] arm64: dts: stingray: Add otp device node
In-Reply-To: <efaf0373-2959-b238-e5f3-ae7e16534384@gmail.com>
References: <1527106630-4760-1-git-send-email-scott.branden@broadcom.com>
 <c9219029-6e45-1889-6326-470d2bc9e46c@gmail.com>
 <f6f3e76e-eac9-797d-fea5-eac64327ec7f@broadcom.com>
 <efaf0373-2959-b238-e5f3-ae7e16534384@gmail.com>
Message-ID: <e641f180-0b7e-678c-07c4-834ff0676b34@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18-06-04 02:33 PM, Florian Fainelli wrote:
> On 06/04/2018 02:30 PM, Scott Branden wrote:
>> Hi Florian,
>>
>>
>> On 18-06-04 02:24 PM, Florian Fainelli wrote:
>>> On 05/23/2018 01:17 PM, Scott Branden wrote:
>>>> Add otp device node for Stingray SOC.
>>>>
>>>> Fixes: 2fa9e9e29ea2 ("arm64: dts: Add GPIO DT nodes for Stingray SOC")
>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>> Applied to devicetree-arm64/next with s/otp/OTP/ and removing the Fixes
>>> line since that is not a bug fix AFAICT.
>> It fixes the issue that OTP is not active as it is missing the device node?
> By that token, any peripheral that is being added at some point in the
> lifetime of this DTS would qualify as a bugfix when it is in fact
> feature/peripheral enabling.
>
> I could not see the relationship between the commit being provided in
> the "Fixes:" tag and OTP, am I missing something?
The relationship is the fixes tag points was selected to the last tag 
when the commit applies directly against (and is far enough back that it 
covers any possible LTS kernels that would have needed it). In this case 
I don't care too much about whether this is fixed in LTS or not.? If 
needed I'll send a request for the commit be ported to stable.
