From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 7 Apr 2011 01:20:17 +0200
Subject: [RFC][PATCH] bcmai: introduce AI driver
In-Reply-To: <1302124737.27258.7.camel@dev.znau.edu.ua>
References: <1302033463-1846-1-git-send-email-zajec5@gmail.com>
	<op.vtisojsk3ri7v4@arend-laptop>
	<BANLkTinubrmryu=Bco5_AVcj_arn7SWZxw@mail.gmail.com>
	<op.vti9ote53ri7v4@arend-laptop>
	<BANLkTin-u=U_-cUH9oCco0LjEBuQmh4wag@mail.gmail.com>
	<BANLkTi=x89+52cMeutOB7J--QQta+mX_wg@mail.gmail.com>
	<1302123428.20093.6.camel@maggie>
	<BANLkTimGSoYzp0Z4vyCS_H5PDKhgjYuLBA@mail.gmail.com>
	<1302124112.20093.11.camel@maggie>
	<BANLkTik76dwwnmmPzXL9Kkk7fdt01QPzZA@mail.gmail.com>
	<1302124737.27258.7.camel@dev.znau.edu.ua>
Message-ID: <BANLkTi=4-LgrkjG96+Ar3SjMOsKh-dMuLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 6 kwietnia 2011 23:18 u?ytkownik George Kashperko
<george@znau.edu.ua> napisa?:
>> We have 2 windows. I didn't try this, but let's assume they have no
>> limitations. We can use first window for one driver only, second
>> driver for second driver only. That gives us 2 drivers simultaneously
>> working drivers. No driver need to reset core really often (and not
>> inside interrupt context) so we will switch driver's window to agent
>> (from core) only at init/reset.
>>
>> The question is what amount of driver we will need to support at the same time.
>>
>
> I guess (correct me please, Broadcom guys if I'm wrong) there are two
> functions two-head w11 pci host and therefore 4 sliding windows, 2 per
> each function.

I don't understand you. Can you use more friendly language? functions?
2head? w11?

-- 
Rafa?
