From: ttnguyen@apm.com (Tai Tri Nguyen)
Date: Wed, 6 Jul 2016 18:01:39 -0700
Subject: [PATCH v7 1/4] MAINTAINERS: Add entry for APM X-Gene SoC PMU
 driver
In-Reply-To: <1467852224.8360.60.camel@perches.com>
References: <1467850045-10584-1-git-send-email-ttnguyen@apm.com>
 <1467850045-10584-2-git-send-email-ttnguyen@apm.com>
 <1467850751.8360.56.camel@perches.com>
 <CACgAJHyvusvRPKNaxHLFK=gWw2UUtjV80H175eRu6EieutxNiw@mail.gmail.com>
 <1467852224.8360.60.camel@perches.com>
Message-ID: <CACgAJHzoRwfvnGuKLpymLQ2+FNjxZhfg2YnxHyP3CndrjAQapw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

On Wed, Jul 6, 2016 at 5:43 PM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2016-07-06 at 17:35 -0700, Tai Tri Nguyen wrote:
>> Hi Joe,
>
> Ch?o Tai.
>

Thanks for the greeting!

>> On Wed, Jul 6, 2016 at 5:19 PM, Joe Perches <joe@perches.com> wrote:
>> > On Wed, 2016-07-06 at 17:07 -0700, Tai Nguyen wrote:
> []
>> > > diff --git a/MAINTAINERS b/MAINTAINERS
>> > []
>> > >
>> > > @@ -8593,6 +8593,14 @@ L:     linux-scsi at vger.kernel.org
>> > >  S:   Supported
>> > >  F:   drivers/scsi/pm8001/
>> > >
>> > > +PMU-XGENE
>> > > +APPLIED MICRO (APM) X-GENE SOC PMU
>> > One line section header please.
>> Is this strictly required?
>
> Yes.
>
> get_maintainer.pl doesn't like multiple line section headers.
>

Okay, I'll drop the first line and move it accordingly.

Regards,
Tai
