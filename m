From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Apr 2015 00:02:42 -0300
Subject: Bug#782364: linux-image-3.16.0-4-armmp: please configure drivers
 for both Cubox i4pro real time clocks
In-Reply-To: <1428710930.29665.17.camel@decadent.org.uk>
References: <20150410232854.23367.58862.reportbug@cube.rcthomas.org>
 <1428710930.29665.17.camel@decadent.org.uk>
Message-ID: <CAOMZO5BrWbxarSEEC52Kb7=QR4K2e1qyAmMz3Rx+nq9r1vbdcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 9:08 PM, Ben Hutchings <ben@decadent.org.uk> wrote:

>> Whenever I reset my cubox-i4Pro by disconnecting the power plug, the hardware real-time-clock gets
>> reset to midnight UTC, Dec 31, 1970.
>> Even though the SolidRun literature says that the i4Pro has a battery backed RTC.

> If this RTC is not battery backed, it seems like it ought to be disabled
> in this board's device tree.

Agreed. Just sent a patch for this.

>> # CONFIG_RTC_DRV_PCF8523 is not set
>>
>> and
>>
>> CONFIG_RTC_DRV_SNVS=y

And also a patch for turning on this option as well.

Regards,

Fabio Estevam
