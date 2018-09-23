From: olof@lixom.net (Olof Johansson)
Date: Sun, 23 Sep 2018 14:13:23 +0100
Subject: [PATCH v12 0/6] drivers: Introduce firmware driver for ZynqMP core
In-Reply-To: <CY1PR02MB21385F71D8BC4498654CD0BFB8130@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
 <CY1PR02MB21385F71D8BC4498654CD0BFB8130@CY1PR02MB2138.namprd02.prod.outlook.com>
Message-ID: <CAOesGMgUaQMcTQsbLR_qN95QPfOE1gCJuM9=6AiFLg+_t98qaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 5:46 PM, Jolly Shah <JOLLYS@xilinx.com> wrote:
> Hi Olof,
>
> As suggested, this patchset is generated without ioctl interface. Please review. If you are ok, Michal can create a pull request for merge.

Hi,

I replied on the other thread as well; it sounds like you will need
something _like_ the ioctl interface for some of the dependent
drivers. For those, would it be possible to only expose some of the
ioctls through the interface, and not just pass through any call? I
think that'd probably take care of my concern.

But yeah, go ahead and stage these in a pull request for now, that way
we can take care of these and merge them as the rest are getting
ready. I don't want to hold you up more than needed; the patch set is
already up to a very high version number and it's not fair to make you
rework it completely yet again.



-Olof
