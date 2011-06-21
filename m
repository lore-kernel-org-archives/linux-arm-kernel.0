From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 21 Jun 2011 09:54:35 -0600
Subject: [RFC 0/8] Introducing a generic AMP/IPC framework
In-Reply-To: <201106211620.02065.arnd@arndb.de>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<201106211620.02065.arnd@arndb.de>
Message-ID: <BANLkTikwA=_jHmnb7CT9aAmJ_GnLXZ9OAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 8:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> Hi Ohad,
>
> On Tuesday 21 June 2011, Ohad Ben-Cohen wrote:
>
>> This patch set adds a generic AMP/IPC framework which makes it possible to
>> control (power on, boot, power off) and communicate (simply send and receive
>> messages) with those remote processors.
>
> This looks really nice overall, but I don't currently have time for a
> more in-depth review. My feeling is that you are definitely on the right
> track here, and the plans you list as TODO to continue are all good.

Second that.  I'm happy to see the shift over to virtio, I think that
is the right direction overall.  I'll try to carve out some time for a
detailed review.

g.
