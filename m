From: olof@lixom.net (Olof Johansson)
Date: Thu, 19 Sep 2013 18:39:40 -0700
Subject: [PATCH] ARM: tegra_defconfig: enable CONFIG_ARM_APPENDED_DTB
In-Reply-To: <523BA64F.1050607@wwwdotorg.org>
References: <1379638594-28888-1-git-send-email-olof@lixom.net>
 <CAKCjkJbavWtWBxvKqpesmJfcKTUCpbsM_xL0JfS49vOpkZ8AUw@mail.gmail.com>
 <CAOesGMjP+QMyuLCykg0nW4yWwmnNtoyzf7nK2dPAWuqcpfp5OA@mail.gmail.com>
 <523BA64F.1050607@wwwdotorg.org>
Message-ID: <CAOesGMh8NE7h=BH2sPrG4eE3Vbv0Q5+hCj52gi0072phtjcghw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 6:35 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 09/19/2013 07:09 PM, Olof Johansson wrote:
>> They do? The hardware I have came with a very old u-boot. Got a link
>> to the newer one?
>
> Mainline U-Boot runs nicely on the TrimSlice. Missing functionality
> includes PCIe Ethernet and HDMI, but everything else works fine IIRC.
> You can flash it using:
>
> https://github.com/NVIDIA/tegra-uboot-flasher-scripts
>
> (read README-developer.txt first, then README-user.txt)

Oh great. Unfortunately lack of PCI-e makes it hard to network boot
(unless I add a redundant usb-ethernet adapter on it). Hmm.


-Olof
