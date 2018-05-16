From: rishabhb@codeaurora.org (rishabhb at codeaurora.org)
Date: Wed, 16 May 2018 16:32:27 -0700
Subject: [PATCH v6 1/2] dt-bindings: Documentation for qcom, llcc
In-Reply-To: <152649413707.210890.2655572242392552759@swboyd.mtv.corp.google.com>
References: <1525810921-15878-1-git-send-email-rishabhb@codeaurora.org>
 <1525810921-15878-2-git-send-email-rishabhb@codeaurora.org>
 <152649021310.210890.14841324536807182632@swboyd.mtv.corp.google.com>
 <385198cbb91c4a36ad758997916ad271@codeaurora.org>
 <152649413707.210890.2655572242392552759@swboyd.mtv.corp.google.com>
Message-ID: <079348edcb511cefb9f4d76877d50cb7@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-05-16 11:08, Stephen Boyd wrote:
> Quoting rishabhb at codeaurora.org (2018-05-16 10:33:14)
>> On 2018-05-16 10:03, Stephen Boyd wrote:
>> > Quoting Rishabh Bhatnagar (2018-05-08 13:22:00)
>> 
>> >> +
>> >> +- max-slices:
>> >> +       usage: required
>> >> +       Value Type: <u32>
>> >> +       Definition: Number of cache slices supported by hardware
>> >> +
>> >> +Example:
>> >> +
>> >> +       llcc: qcom,llcc at 1100000 {
>> >
>> > cache-controller at 1100000 ?
>> >
>> We have tried to use consistent naming convention as in llcc_*
>> everywhere.
>> Using cache-controller will mix and match the naming convention. Also 
>> in
>> the documentation it is explained what llcc is and its full form.
>> 
> 
> DT prefers standard node names as opposed to vendor specific node 
> names.
> Isn't it a cache controller? I fail to see why this can't be done.
Hi Stephen,
The driver is vendor specific and also for uniformity purposes we 
preferred
to go with this name.
