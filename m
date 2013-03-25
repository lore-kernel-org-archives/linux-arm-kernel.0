From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 25 Mar 2013 13:23:32 +0100
Subject: [PATCH v2 00/14] Marvell EBU thermal sensor consolidation
In-Reply-To: <20130325104513.GC2502@localhost>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130325093001.GH5627@lunn.ch> <20130325104513.GC2502@localhost>
Message-ID: <CABJ1b_S9c=tFT17=HycmuRbW1g4y8AvWJpmwMRJwvQ214Yb3fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 11:45 AM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> On Mon, Mar 25, 2013 at 10:30:01AM +0100, Andrew Lunn wrote:
>> I've not a strong opinion, but i think separate drivers are better.
>
> Don't you think a single driver could make maintenance cheaper?

Ezequiel, Andrew,

just to sum up my opinion on the whole discussion

+1 for formula fixes for kirkwood and dove
+1 for separate drivers
+1 for thermal-mmio as Jason Gunthorpe suggested

And then port thermal drivers to thermal-mmio..

Sebastian
