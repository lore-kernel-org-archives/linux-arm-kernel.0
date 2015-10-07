From: lho@apm.com (Loc Ho)
Date: Wed, 7 Oct 2015 12:55:31 -0700
Subject: [PATCH RFC] apei: xgene: Add ACPI APEI support for X-Gene
In-Reply-To: <20151006113133.GA28484@nazgul.tnic>
References: <1443747112-24814-1-git-send-email-lho@apm.com>
 <20151002075411.GB16538@pd.tnic>
 <CAPw-ZTn5stnEobMH018oLPn3nDO1uweVeVs=Otg3-6cXBWLz6g@mail.gmail.com>
 <20151006113133.GA28484@nazgul.tnic>
Message-ID: <CAPw-ZTnxKPM1oU3OayGTGphrdAdJLTPXT4Yna7raRqROvhksSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasx/Fu,

>> Yes... We can make this generic. The only non-generic is the way the
>> interrupt is cleared. As of right now, the method of clearing the
>> interrupt is by writing back the same value as read. This would be
>> fine for most.
>
> Fine for most what? APM hardware, other hw?

In general, most HW states are cleared with writing an 1 - but it is
HW implementation specific.

>
>> But to ensure 100% coverage, would an AML method be better or needed?
>
> No idea, I'm not an ACPI guy. You probably should get in touch with the
> people working on the ARM64 APEI driver and hash that out with them.

Is there an thread on ACPI APEI support going on currently for ARM?

-Loc
