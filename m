From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 12 Jun 2015 11:24:22 +0200
Subject: [PATCH v2 06/10] pinctrl: berlin: use proper compatibles
In-Reply-To: <20150612090537.GB29596@kwain>
References: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
 <1425654328-26298-7-git-send-email-antoine.tenart@free-electrons.com>
 <CACRpkda-4SahLjwe09D-Hb8p0nQFdG1Zc_xvLPwLGYQMkJQaXA@mail.gmail.com>
 <20150612090537.GB29596@kwain>
Message-ID: <557AA546.8030505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2015 11:05 AM, Antoine Tenart wrote:
> On Wed, Jun 10, 2015 at 09:13:55AM +0200, Linus Walleij wrote:
>> On Fri, Mar 6, 2015 at 4:05 PM, Antoine Tenart
>> <antoine.tenart@free-electrons.com> wrote:
>>
>>> The Berlin pin-controller driver was sharing the chip and system
>>> controller nodes with the clock and the reset drivers. They all shared
>>> the same compatible. With the introduction of the Marvell Berlin MFD
>>> controller, the Berlin pin-controller driver has now its own node.
>>> Update its compatibles to not share anymore the ones of the chip and
>>> system controllers.
>>>
>>> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
>>
>> Antoine, how is this series going?
>
> The series should be in the berlin tree at the moment.

Not only berlin, but also arm-soc:

[1] https://lkml.org/r/5498391.Fl346EDjWm at wuerfel
[2] https://lkml.org/r/2918562.6HiyIinobj at wuerfel

Sebastian
