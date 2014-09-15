From: jcm@redhat.com (Jon Masters)
Date: Mon, 15 Sep 2014 17:55:41 -0400
Subject: [PATCH v4 10/18] ACPI / table: Print GIC information when MADT
 is parsed
In-Reply-To: <CAOesGMjcXYjmUzZqGncnkN-uhnLC1ey2vqeqE4MQ5UDm8BaYTg@mail.gmail.com>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>	<1410530416-30200-11-git-send-email-hanjun.guo@linaro.org>	<20140915064010.GD26649@localhost>	<20140915175250.8177DC40A42@trevor.secretlab.ca>
 <CAOesGMjcXYjmUzZqGncnkN-uhnLC1ey2vqeqE4MQ5UDm8BaYTg@mail.gmail.com>
Message-ID: <5417605D.7070303@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2014 02:01 PM, Olof Johansson wrote:
> On Mon, Sep 15, 2014 at 10:52 AM, Grant Likely <grant.likely@linaro.org> wrote:
>> On Sun, 14 Sep 2014 23:40:10 -0700, Olof Johansson <olof@lixom.net> wrote:
>>> On Fri, Sep 12, 2014 at 10:00:08PM +0800, Hanjun Guo wrote:
>>>> When MADT is parsed, print GIC information to make the boot
>>>> log look pretty.
>>>
>>> If you do this for prettiness, having an example output in the commit
>>> message would be a nice touch.
>>
>> Agreed.

Here's example output from a hardware platform (just as an example in
this thread, mostly for archiving purposes):

[    0.000000] ACPI: GICC (acpi_id[0x0000] address[00000000e112f000]
MPDIR[0x0] enabled)
[    0.000000] ACPI: GICC (acpi_id[0x0001] address[00000000e112f000]
MPDIR[0x1] enabled)
[    0.000000] ACPI: GICC (acpi_id[0x0100] address[00000000e112f000]
MPDIR[0x100] enabled)
[    0.000000] ACPI: GICC (acpi_id[0x0101] address[00000000e112f000]
MPDIR[0x101] enabled)
[    0.000000] ACPI: GICC (acpi_id[0x0200] address[00000000e112f000]
MPDIR[0x200] enabled)
[    0.000000] ACPI: GICC (acpi_id[0x0201] address[00000000e112f000]
MPDIR[0x201] enabled)

Jon.
