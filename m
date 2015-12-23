From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Wed, 23 Dec 2015 17:22:41 -0500
Subject: [PATCH v5 3/7] ARM: dts: imx: Add Advantech BA-16 Qseven module
In-Reply-To: <20151222113742.GA26290@tiger>
References: <1449177036-13317-1-git-send-email-akshay.bhat@timesys.com>
 <1449177036-13317-4-git-send-email-akshay.bhat@timesys.com>
 <20151222113742.GA26290@tiger>
Message-ID: <567B1EB1.40208@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/22/2015 06:40 AM, Shawn Guo wrote:
> On Thu, Dec 03, 2015 at 04:10:32PM -0500, Akshay Bhat wrote:

>> +
>> +	rtc at 32 {
>> +		compatible = "epson,rx8010";
>
> Is this compatible string documented somewhere?
>
Patches have been submitted to update the documentation for the above 
string along with a couple others that were missing/incorrect:

http://marc.info/?l=linux-i2c&m=145089597514804&w=2
http://marc.info/?l=linux-i2c&m=145089715915019&w=2
http://marc.info/?l=linux-i2c&m=145089835615289&w=2
