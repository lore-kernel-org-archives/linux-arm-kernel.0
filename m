From: ming.lei@canonical.com (Ming Lei)
Date: Thu, 19 Jan 2012 21:14:54 +0800
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <CAMsRxfJ2VrfFZevkxoZzSD5fZn1CErF68y0ny+MZi5r___ERJA@mail.gmail.com>
References: <CAAO=S0+L2Q1YZC-pfm2Lz8jPooTeHYOMaZbtRgHYFoL_m7rvhA@mail.gmail.com>
 <4F0B182D.7060507@us.ibm.com>
 <20120109224945.GA23090@mudshark.cambridge.arm.com>
 <CACVXFVMnAt_YpYNC5B6W4Vh4HvtVS3D6jRORUw0AW5a4ub5aOw@mail.gmail.com>
 <CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
 <CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
 <CAMsRxfLtLnMiP0ZGr6rNLv-UeLUwOSJ=7do2nezOU5OkOA+MbQ@mail.gmail.com>
 <CACVXFVMbrQGi4Sg9TUPP5Bcc5kzFoX74n=ii4QrDRudbuDHOGg@mail.gmail.com>
 <CAMsRxfJmHkZw2f0A+4FsStJpXk_vrxvDduRcRGkcWpqp8a9m_w@mail.gmail.com>
 <CACVXFVOQNDRs=c8A2YC+WvYAHs5Abbz-QUEe1VJqrj2esFO11g@mail.gmail.com>
 <CAMsRxf+e38jRcyxESLhYDZ3OL910AQdapZD9P8vWDXfUE34DAA@mail.gmail.com>
 <CACVXFVPnhSy_DbdK+ro8G78QjL2s6fBBq1Dvq-pmxJ20qA-ymA@mail.gmail.com>
 <CAMsRxfJ2VrfFZevkxoZzSD5fZn1CErF68y0ny+MZi5r___ERJA@mail.gmail.com>
Message-ID: <CACVXFVNixEUKmDf2iYtdJVThkYg3UeZEurbFhrod5NZhDyKRpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 8:51 PM, stephane eranian
<eranian@googlemail.com> wrote:
> On Thu, Jan 19, 2012 at 1:45 PM, Ming Lei <ming.lei@canonical.com> wrote:
>> Hi,
>>
>> On Thu, Jan 19, 2012 at 7:34 PM, stephane eranian
>> <eranian@googlemail.com> wrote:
>>> Hi,
>>>
>>> Ok some update on this.
>>> With your .config file + 3.2.0 (Linus) + patch 3, 4, 5, 6, I get a kernel that
>>
>> You forget patch 1 and patch 2?
>>
> They are already in 3.2.0. Unless I am mistaken.

Sorry, I just found that they have been merged to 3.2.

>
> are you sure you don't have anything else applied?

Yes, I am sure, maybe it is caused by uboot and mlo, I will email them
to you in private mail.

thanks,
--
Ming Lei
