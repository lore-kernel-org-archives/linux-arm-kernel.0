From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Apr 2018 14:03:00 +0200
Subject: [PATCH v2] MAINTAINERS: update entry for ARM/berlin
In-Reply-To: <20180402102819.599ac67f@xhacker.debian>
References: <20180330110211.36455347@xhacker.debian>
 <20180330135932.GB28244@lunn.ch>
 <20180402102819.599ac67f@xhacker.debian>
Message-ID: <CAK8P3a3seSZOocrFtdJJzjmDC8YAAXzicHW_YuXh7ivgYijgAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 2, 2018 at 4:28 AM, Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
> On Fri, 30 Mar 2018 15:59:32 +0200 Andrew Lunn wrote:
>
>> On Fri, Mar 30, 2018 at 11:02:11AM +0800, Jisheng Zhang wrote:
>> > Synaptics has acquired the Multimedia Solutions Business of Marvell[1].
>> > So change the berlin entry name and move it to its alphabetical
>> > location. We move to ARM/Synaptics instead of ARM/Marvell.
>> >
>> > This patch also updates my email address from marvell to synaptics.
>> >
>> > [1] https://www.synaptics.com/company/news/conexant-marvell
>> >
>> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>>
>> Thanks for the link
>>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>
>> Do you still plan to move the DT files from the Marvell subdirectory?
>> Are the locations of these files considered fixed?
>>
>
> For new SoCs, the DT files will be put into synaptics sub-directory.
> But for existing arm64 berlin DT files which currently sits in
> arch/arm64/boot/dts/marvell, I dunno the proper solution. Could
> you please give some suggestions? How do other vendors handle this
> situation in the past?

There is no good solution, we sometimes move files, other times we don't.

Here, I would probably move it out, but I'd leave it up to you.

      Arnd
