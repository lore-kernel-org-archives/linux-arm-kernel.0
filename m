From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 6 Oct 2016 10:59:01 +0100
Subject: Coresight ETF trace dump failed in Juno r1 with 4.8-rc8
In-Reply-To: <CAGhh56Fuvkejfb0jMhtHq2saLQT6iSQa0rioW7mOpELugdmtPQ@mail.gmail.com>
References: <CAGhh56F-VWCCy82msQ8CimZ4a0a2h=tqR2qv1KcfeyuQXo=R1w@mail.gmail.com>
 <42c2ac9c-abdf-5341-01b5-3f342c5164b7@arm.com>
 <CAGhh56H7a9oEYxzEA4gGvBey=COMqwgisd4tzewU8DLGcGrsww@mail.gmail.com>
 <434a0256-de86-c1f0-0dc3-a38f55596e8e@arm.com>
 <CAGhh56GeZkLT=sN4cEhUJMeuz+ZD6jMnU2sbb3yRVLESUcWrtg@mail.gmail.com>
 <7e1e514b-fc3b-ca96-4631-88d537019e08@arm.com>
 <CAGhh56Fuvkejfb0jMhtHq2saLQT6iSQa0rioW7mOpELugdmtPQ@mail.gmail.com>
Message-ID: <c0fb1444-7c81-b11f-fbbc-10b416de2167@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/10/16 06:21, Venkatesh Vivekanandan wrote:
> On Wed, Oct 5, 2016 at 4:12 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>> On 05/10/16 06:27, Venkatesh Vivekanandan wrote:
>>

[...]

>> OK, this looks as good as what Suzuki has, so should be fine.
>> But it doesn't list SCP version, can you see that from the Linux boot
>> logs ?(something like below)
>>
>> "scpi_protocol scpi: SCP Protocol 1.2 Firmware 1.17.0 version"
>
> [    2.537096] scpi_protocol scpi: SCP Protocol 1.0 Firmware 1.11.0 version
>

So you have not upgraded the firmware yet ? IIRC, the latest release
link I provided has v1.16.0 or 1.17.0

v1.11.0 is almost a year old and I have worked with the firmware team to
get various issues around ETM I encountered since then. If you are
facing issue even with latest release firmware, then I will be able to
look at it and help you.

-- 
Regards,
Sudeep
