From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Wed, 10 May 2017 13:20:49 -0500
Subject: [PATCH v6 18/23] drivers/fsi: Document FSI master sysfs files in
 ABI
In-Reply-To: <CACPK8Xc4kv1Y_82ShYAfNjzf480Ab1ws95QSxPT8VE2XF+nueA@mail.gmail.com>
References: <20170410194706.64280-1-cbostic@linux.vnet.ibm.com>
 <20170410194706.64280-19-cbostic@linux.vnet.ibm.com>
 <CACPK8Xc4kv1Y_82ShYAfNjzf480Ab1ws95QSxPT8VE2XF+nueA@mail.gmail.com>
Message-ID: <e3aa64b3-20b7-8de8-7f30-1cf1a7a3755d@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/10/17 2:30 AM, Joel Stanley wrote:
> On Tue, Apr 11, 2017 at 5:17 AM, Christopher Bostic
> <cbostic@linux.vnet.ibm.com> wrote:
>> From: Chris Bostic <cbostic@linux.vnet.ibm.com>
>>
>> Add info for sysfs scan file in Documentaiton ABI/testing
> You are missing documentation for the 'raw', 'term' and 'break' files.

Hi Joel,

Yes, I've made your suggested changes in my pending release version 7 
patch set.

>> Signed-off-by: Chris Bostic <cbostic@linux.vnet.ibm.com>
>> ---
>>   Documentation/ABI/testing/sysfs-bus-fsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-fsi
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-fsi b/Documentation/ABI/testing/sysfs-bus-fsi
>> new file mode 100644
>> index 0000000..dfcbc1b
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-fsi
>> @@ -0,0 +1,6 @@
>> +What:           /sys/bus/platform/devices/fsi-master/scan
> This has been renamed 'rescan' in this series. The path has changed too.
>
>> +KernelVersion:  4.9
> This should be 4.12 I guess, assuming we get it merged this cycle.

Will update.

Thanks
-Chris
>
>> +Contact:        cbostic at us.ibm.com
>> +Description:
>> +                Initiates a FSI master scan for all connected
>> +                slave devices on its links.
>> --
>> 1.8.2.2
>>
