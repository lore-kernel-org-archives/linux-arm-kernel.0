From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 14 Nov 2016 16:04:00 -0700
Subject: [PATCH fpga 5/9] fpga zynq: Remove priv->dev
In-Reply-To: <CAAtXAHe60QjyitDxkEzc9+Zr99mj0SeWFUOW0SOexGnBvuqGjw@mail.gmail.com>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-6-git-send-email-jgunthorpe@obsidianresearch.com>
 <alpine.DEB.2.10.1611140913280.3739@atull-VirtualBox>
 <CAAtXAHe60QjyitDxkEzc9+Zr99mj0SeWFUOW0SOexGnBvuqGjw@mail.gmail.com>
Message-ID: <20161114230400.GB4874@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 09:20:38AM -0800, Moritz Fischer wrote:
> this one could be independent of the other patches, this is cleanup and
> could be merged before the rest (that's still in discussion) if you pull it out.

As I said in the cover letter, several of the patches are just fixes
and can be applied, but they are all linked by patch context so are
presented as a series.

Lets get as many reviewed as possible and then I can repost them in a
different order if necessary.

The first 5 are all straigtfoward and should be no problem to get
ackd. We've talked about the sanity check patch enough, lets just go
ahead with it now.

Jason
