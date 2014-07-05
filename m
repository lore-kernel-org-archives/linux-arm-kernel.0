From: olof@lixom.net (Olof Johansson)
Date: Fri, 4 Jul 2014 23:06:57 -0700
Subject: [GIT PULL] omap fixes against v3.16-rc1
In-Reply-To: <20140705044703.GA5201@quad.lixom.net>
References: <20140617145854.GT17845@atomide.com>
 <20140630070857.GK28884@atomide.com>
 <20140705044703.GA5201@quad.lixom.net>
Message-ID: <CAOesGMh5faPEA167hqDff=NU0Tk79wt6fhxZgiP5Q4xgsvO6oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 4, 2014 at 9:47 PM, Olof Johansson <olof@lixom.net> wrote:
> On Mon, Jun 30, 2014 at 12:08:57AM -0700, Tony Lindgren wrote:
>> * Tony Lindgren <tony@atomide.com> [140617 08:01]:
>> > The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
>> >
>> >   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
>> >
>> > are available in the git repository at:
>> >
>> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.16/fixes-against-rc1
>> >
>> > for you to fetch changes up to edc56f871eefbc56baf1fd981eeff35ef447925c:
>> >
>> >   ARM: dts: dra7-evm: remove interrupt binding (2014-06-17 01:22:55 -0700)
>
> Merged. Apologies for the delay, I was planning on handling this earleir this
> week. I'll send this up tonight or tomorrow.

Hmm. for-next with this merged in stopped omap5uevm from booting
(Can't find mmcblk1 which I keep the rootfs on), see
http://arm-soc.lixom.net/bootlogs/arm-soc/v3.16-rc1-76-gf5ee1b1/. One
of the three configs had a DHCP timeout, I'm going to rebuild the
network here to reduce the frequency of those.

I'll try bisecting tomorrow. Not sending it up with this known
breakage, hopefully it's something simple.


-Olof
