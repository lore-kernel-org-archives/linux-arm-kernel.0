From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 4 Oct 2016 11:30:59 +0100
Subject: Coresight ETF trace dump failed in Juno r1 with 4.8-rc8
In-Reply-To: <CAGhh56H7a9oEYxzEA4gGvBey=COMqwgisd4tzewU8DLGcGrsww@mail.gmail.com>
References: <CAGhh56F-VWCCy82msQ8CimZ4a0a2h=tqR2qv1KcfeyuQXo=R1w@mail.gmail.com>
 <42c2ac9c-abdf-5341-01b5-3f342c5164b7@arm.com>
 <CAGhh56H7a9oEYxzEA4gGvBey=COMqwgisd4tzewU8DLGcGrsww@mail.gmail.com>
Message-ID: <cc531f08-d09b-1976-90c2-377a5878b1eb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/10/16 06:37, Venkatesh Vivekanandan wrote:
> On Mon, Oct 3, 2016 at 6:44 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Hi Venkatesh,
>>
>> On 03/10/16 12:36, Venkatesh Vivekanandan wrote:
>>>
>>> Hi All,
>>>
>>> I am trying to collect ETF trace from Juno R1 and could see "cpu
>>> stall" while dumping the trace. Attached is the log of sequence
>>> followed. Was trying to collect the trace data from hardware and see
>>> if it is any valid data. Am I missing anything here?.
>>>
>>
>> There are few fixes from me and Suzuki queued for v4.9.
>> Can you check if this issue persists even on linux-next ?
>
> Issue is the same in linux-next as well. Please find the attached log.
>

OK, what do you mean by the issue still being present. I no longer see
any ETM failures or messages. Does the system hang when you try to read
/dev/<addr>.etf ?

Also the RCU stalls could be related to CPUIdle. Are you using latest
versions of trusted firmware ?

-- 
Regards,
Sudeep
