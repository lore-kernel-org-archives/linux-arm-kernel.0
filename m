From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Tue, 8 Mar 2016 06:45:20 -0600
Subject: commit dfd55ad8 breaks Seattle B0
In-Reply-To: <CAKv+Gu_83N9CzYfbLPQY2BEuhA=h1sYPXN+nkCURtbA32gw3OA@mail.gmail.com>
References: <56DE0115.9040101@redhat.com>
 <CAKv+Gu_83N9CzYfbLPQY2BEuhA=h1sYPXN+nkCURtbA32gw3OA@mail.gmail.com>
Message-ID: <56DEC960.8020100@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/2016 06:49 PM, Ard Biesheuvel wrote:
> (+ Will)
>
> On 8 March 2016 at 05:30, Mark Langsdorf <mlangsdo@redhat.com> wrote:
>
> Thanks for the report. Although next time, perhaps put my name in the
> cc box? :-)

Sorry, I realized I should have done that a couple of hours too late.

>> I get the following error when booting v4.5-rc7 on Seattle B0
>> using the same config file that boots successfully on v4.5-rc6.
>>
>> Removing commit dfd55ad8 allows v4.5-rc7+ to boot successfully.
>>
>
> I will investigate today. So other than 64k pages, is there anything
> special about your config?

Thank you.

My config differs substantially from defconfig but I'm not sure
what else is special. gzip'd config attached.

--Mark Langsdorf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: rh.config.gz
Type: application/gzip
Size: 28406 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160308/56bc7c0c/attachment-0001.gz>
