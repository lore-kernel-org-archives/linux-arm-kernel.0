From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Thu, 5 Jan 2017 14:31:52 -0800
Subject: [PATCH v2 09/19] ARM: dts: imx6-sabreauto: add the ADV7180 video
 decoder
In-Reply-To: <acbdc873-3166-f56d-e6d1-948becb1a57c@mentor.com>
References: <1483477049-19056-1-git-send-email-steve_longerbeam@mentor.com>
 <1483477049-19056-10-git-send-email-steve_longerbeam@mentor.com>
 <acbdc873-3166-f56d-e6d1-948becb1a57c@mentor.com>
Message-ID: <3ac69119-d0aa-2758-ea67-991ad31fef84@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/04/2017 04:41 AM, Vladimir Zapolskiy wrote:
> On 01/03/2017 10:57 PM, Steve Longerbeam wrote:
>> +
>> +			camera: adv7180 at 21 {
> adv7180: camera at 21

done.

>>   
>> +		pinctrl_ipu1_csi0: ipu1grp-csi0 {
> Please rename node name to ipu1csi0grp.

done.


Steve
