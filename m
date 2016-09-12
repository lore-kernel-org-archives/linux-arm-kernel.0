From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 12 Sep 2016 12:22:39 +0200
Subject: [PATCHv3 0/3] Devicetree bindings for Ion
In-Reply-To: <1472601869-19469-1-git-send-email-labbott@redhat.com>
References: <1472601869-19469-1-git-send-email-labbott@redhat.com>
Message-ID: <20160912102239.GA5034@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 05:04:26PM -0700, Laura Abbott wrote:
> Hi,
> 
> This is a long overdue resend and slight update from the last version[1] of
> Ion devicetree bindings.
> 
> The goal here is to keep the Ion bindings minimalist. I experimented with
> dropping all but a dummy devicetree node and just matching on the machine
> name in the platform file. This ends up being a nightmare for the DMA (i.e. CMA)
> heap type. That heap requires a device structure to do its allocation and
> setting up a device structure properly isn't pretty. I have other ideas for
> working with that heap if this gets NAKed.
> 
> I've thought about the idea of a devicetree overlay for specifying more
> platform configuration but that a) requires Android actually load the overlay
> at the right time in the framework and b) opens up an entirely new can of
> worms.
> 
> In conclusion, if we assume that Ion platform support is something anyone
> actually wants, this is still the least bad and intrusive idea I've come up
> with. There exists hisilicon Ion code but it came in without being fully acked.
> I've converted it over as an example of how it might look.
> 
> As always, feedback appreciated.

Give a total lack of feeback, I've now applied these patches :)

thanks,

greg k-h
