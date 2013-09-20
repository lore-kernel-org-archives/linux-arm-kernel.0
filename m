From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 20 Sep 2013 09:30:37 +0200
Subject: [PATCH] ARM: tegra_defconfig: enable CONFIG_ARM_APPENDED_DTB
In-Reply-To: <523BABB2.4090200@wwwdotorg.org>
References: <1379638594-28888-1-git-send-email-olof@lixom.net>
 <CAKCjkJbavWtWBxvKqpesmJfcKTUCpbsM_xL0JfS49vOpkZ8AUw@mail.gmail.com>
 <CAOesGMjP+QMyuLCykg0nW4yWwmnNtoyzf7nK2dPAWuqcpfp5OA@mail.gmail.com>
 <523BA64F.1050607@wwwdotorg.org>
 <CAOesGMh8NE7h=BH2sPrG4eE3Vbv0Q5+hCj52gi0072phtjcghw@mail.gmail.com>
 <523BABB2.4090200@wwwdotorg.org>
Message-ID: <20130920073036.GA8575@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 07:58:10PM -0600, Stephen Warren wrote:
> On 09/19/2013 07:39 PM, Olof Johansson wrote:
> > On Thu, Sep 19, 2013 at 6:35 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> >> On 09/19/2013 07:09 PM, Olof Johansson wrote:
> >>> They do? The hardware I have came with a very old u-boot. Got a link
> >>> to the newer one?
> >>
> >> Mainline U-Boot runs nicely on the TrimSlice. Missing functionality
> >> includes PCIe Ethernet and HDMI, but everything else works fine IIRC.
> >> You can flash it using:
> >>
> >> https://github.com/NVIDIA/tegra-uboot-flasher-scripts
> >>
> >> (read README-developer.txt first, then README-user.txt)
> > 
> > Oh great. Unfortunately lack of PCI-e makes it hard to network boot
> > (unless I add a redundant usb-ethernet adapter on it). Hmm.
> 
> I think Thierry was looking into PCIe, although I don't think it's
> working yet. I always just use USB even on TrimSlice since it's easier
> to move the USB connector than the network connector when switching
> machines:-) PCIe works in Linux now though, as of v3.12-rc1.

I have a local branch that makes it work at least on Beaver, but it
causes the kernel PCIe to fail for reasons that I haven't tracked down
yet.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130920/4e88cc2f/attachment.sig>
