From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 3 Oct 2016 14:14:00 +0100
Subject: Coresight ETF trace dump failed in Juno r1 with 4.8-rc8
In-Reply-To: <CAGhh56F-VWCCy82msQ8CimZ4a0a2h=tqR2qv1KcfeyuQXo=R1w@mail.gmail.com>
References: <CAGhh56F-VWCCy82msQ8CimZ4a0a2h=tqR2qv1KcfeyuQXo=R1w@mail.gmail.com>
Message-ID: <42c2ac9c-abdf-5341-01b5-3f342c5164b7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Venkatesh,

On 03/10/16 12:36, Venkatesh Vivekanandan wrote:
> Hi All,
>
> I am trying to collect ETF trace from Juno R1 and could see "cpu
> stall" while dumping the trace. Attached is the log of sequence
> followed. Was trying to collect the trace data from hardware and see
> if it is any valid data. Am I missing anything here?.
>

There are few fixes from me and Suzuki queued for v4.9.
Can you check if this issue persists even on linux-next ?

-- 
Regards,
Sudeep
