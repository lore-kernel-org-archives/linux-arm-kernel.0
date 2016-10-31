From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 31 Oct 2016 21:30:20 +0100
Subject: [PATCH v2 2/2] power: bq27xxx_battery: add poll interval property
 query
In-Reply-To: <CAJ_EiSRzmQHLP2PTfzsLF4uWgYgCiRGsSk=MHbtOC5rgXnnFpw@mail.gmail.com>
References: <1475092512-30555-1-git-send-email-matt@ranostay.consulting>
 <CAKzfze_rv29gwuBGctwTONyw8Oy6fwE+xcN0HMh-ZPB47HKzuQ@mail.gmail.com>
 <CAJ_EiSRzmQHLP2PTfzsLF4uWgYgCiRGsSk=MHbtOC5rgXnnFpw@mail.gmail.com>
Message-ID: <201610312130.20261@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 31 October 2016 21:22:18 Matt Ranostay wrote:
> On Tue, Oct 25, 2016 at 11:47 AM, Matt Ranostay <mranostay@gmail.com>
> wrote:
> > On Mon, Oct 24, 2016 at 1:14 PM, Pavel Machek <pavel@ucw.cz> wrote:
> >> On Mon 2016-10-24 12:58:25, Matt Ranostay wrote:
> >>> Pavel + Sebastian this is the patchset that need I some input on
> >>> :)
> >> 
> >> Better then previous one.
> > 
> >> But my version of bq27xxx_battery.c already contains this:
> > This is for allowing udev rule to set the properties as well.
> > otherwise a kinda crude RUN = " echo value >
> > /sys/module/bq27xxx_battery/parameters/poll_interval" is required.
> 
> Any thoughts on this?

Isn't sysfs /sys/module/bq27xxx_battery/parameters/poll_interval 
attribute what should be used to change module parameters like 
poll_interval?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161031/aa2d9abc/attachment.sig>
