From: lznuaa@gmail.com (Zhi Li)
Date: Fri, 20 Feb 2015 08:15:00 -0600
Subject: [PATCH 1/1 v2] ARM: coresight: fix system halt when etm enable
 and add nosmp to command line
In-Reply-To: <54E6DFDB.8070603@de.bosch.com>
References: <1424354275-18747-1-git-send-email-Frank.Li@freescale.com>
 <54E6DFDB.8070603@de.bosch.com>
Message-ID: <CAHrpEqQ0KURi0vXz8Xmj78ybwBi0YzrdsKkrKpHCQUS6WhCMVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 1:18 AM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> Hi Frank,
>
> On 19.02.2015 14:57, Frank.Li at freescale.com wrote:
>>
>> From: Frank Li <Frank.Li@freescale.com>
>>
>> when nosmp set, only 1 core enabled. try to access disable core will halt.
>> dts need added arm,primecell-periphid =  <id> for none-boot core
>> otherwise amba_device_add will halt when read peripheral id.
>>
>> Signed-off-by: Frank Li <Frank.Li@freescale.com>
>
>
>
> Just out of interest: Do you have the coresight patches working on i.MX6,
> now?

No,  i.MX6 have bugs about coresight.
I worked at MX7.

best regards
Frank Li

>
> I.e. is
>
> http://www.spinics.net/lists/arm-kernel/msg397864.html
>
> clarified, now?
>
> Best regards
>
> Dirk
