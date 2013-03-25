From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 25 Mar 2013 09:39:30 -0300
Subject: [PATCH v2 00/14] Marvell EBU thermal sensor consolidation
In-Reply-To: <CABJ1b_S9c=tFT17=HycmuRbW1g4y8AvWJpmwMRJwvQ214Yb3fw@mail.gmail.com>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130325093001.GH5627@lunn.ch> <20130325104513.GC2502@localhost>
 <CABJ1b_S9c=tFT17=HycmuRbW1g4y8AvWJpmwMRJwvQ214Yb3fw@mail.gmail.com>
Message-ID: <20130325123928.GD2502@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Mon, Mar 25, 2013 at 01:23:32PM +0100, Sebastian Hesselbarth wrote:
> On Mon, Mar 25, 2013 at 11:45 AM, Ezequiel Garcia
> <ezequiel.garcia@free-electrons.com> wrote:
> > On Mon, Mar 25, 2013 at 10:30:01AM +0100, Andrew Lunn wrote:
> >> I've not a strong opinion, but i think separate drivers are better.
> >
> > Don't you think a single driver could make maintenance cheaper?
> 
> Ezequiel, Andrew,
> 
> just to sum up my opinion on the whole discussion
> 

Thanks for jumping in.

> +1 for formula fixes for kirkwood and dove

Could you test the Dove formula fixes and provide a Tested-by?
However little the patches maybe, it still makes me nervous
to send untested patches.

> +1 for separate drivers

I'll send an Armada only patchset soon.

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
