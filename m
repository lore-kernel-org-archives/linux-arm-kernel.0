From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 23 Mar 2016 22:56:59 +0530
Subject: [PATCH v2 00/11] da8xx USB clocks
In-Reply-To: <56EAB38C.9070905@cogentembedded.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <56EAB38C.9070905@cogentembedded.com>
Message-ID: <56F2D1E3.6060608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Thursday 17 March 2016 07:09 PM, Sergei Shtylyov wrote:
> On 3/17/2016 5:26 AM, David Lechner wrote:
> 
>> OK, ready for round two.
> 
>    You're quick... :-)
> 
>> I've added a new callback in the davinci clocks so that they can properly
>> handle clock muxing. The clock functions are pretty much the same as
>> in the
>> previous patch set other than clk_set_parent() now works.
>>
>> The next new thing is a phy driver for the CFGCHIP2 register that
>> controls the
>> SoC USB PHY (both USB 1.1 and USB 2.0). The ohci and musb drivers have
>> been
>> updated to use this new phy driver.
> 
>    Fantastic! At least there's some breakthru on this front.

+1 Thanks a bunch for resurrecting this code.

Regards,
Sekhar
