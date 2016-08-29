From: horms@verge.net.au (Simon Horman)
Date: Mon, 29 Aug 2016 16:04:50 +0200
Subject: [PATCH/RFT v2 0/8] Add SDHI to r8a7796/salvator-x
In-Reply-To: <1471938590-10650-1-git-send-email-horms+renesas@verge.net.au>
References: <1471938590-10650-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20160829140447.GA13348@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 09:49:42AM +0200, Simon Horman wrote:
> Hi,
> 
> this patch set updates drivers, documentation and DT to
> enable SDHI0 & 3 on the r8a7796/salvator-x. This includes
> defining nodes for all available SDHI and GPIO devices.
> 
> I have boot-tested this which seems successful.
> However, I do not have physical access to an r8a7796/salvator-x board
> and the one that I have remote access to does not appear to have
> any SD cards present. I would be grateful of any testing anyone
> can provide.

The board I have access to now has SD cards present and
I have been able to lightly test this patchset. Access
to both SD card slogs seems to work.

> Based on renesas-drivers-2016-08-09-v4.8-rc1
> 
> Provided for testing as the topic/r8a7796-sdhi-v2 branch in
> my renesas tree on kernel.org.
> 
> Changes since v1 noted in individual changelogs.
> Acks from v1 also added.
