From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 27 Jul 2017 16:34:59 +0200
Subject: [PATCH v6 1/1] acpi: apei: Enable APEI multiple GHES source to
 share a single external IRQ
In-Reply-To: <20170727055825.GA4611@nazgul.tnic>
References: <1500661477-6536-1-git-send-email-lho@apm.com>
 <20170722055954.GA2082@nazgul.tnic>
 <1893763.BLgt1zgLk5@aspire.rjw.lan> <1632667.Vgem7HtdXu@aspire.rjw.lan>
 <20170727055825.GA4611@nazgul.tnic>
Message-ID: <CAJZ5v0jVSrsufoWyexb_MWS=ni0CDn7Oo1-oHOcaTxdYpfpQMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 7:58 AM, Borislav Petkov <bp@suse.de> wrote:
> On Wed, Jul 26, 2017 at 08:57:03PM +0200, Rafael J. Wysocki wrote:
>> > Should I apply this or will Tony do that?
>>
>> So am I suppsed to drop this?
>
> Well, as suggested in another mail, I think it'll be best if Tony and I
> put ourselves as reviewers for the APEI crap and you still collect it.
>
> Unless you want to give it to us and we can arrange some pull order to
> send it to you.
>
> What do you prefer?

I can collect it, no problem.

So from now on I will pick up APEI things with ACKs from you or Tony.

Thanks,
Rafael
