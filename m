From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Sep 2013 19:35:11 -0600
Subject: [PATCH] ARM: tegra_defconfig: enable CONFIG_ARM_APPENDED_DTB
In-Reply-To: <CAOesGMjP+QMyuLCykg0nW4yWwmnNtoyzf7nK2dPAWuqcpfp5OA@mail.gmail.com>
References: <1379638594-28888-1-git-send-email-olof@lixom.net>
 <CAKCjkJbavWtWBxvKqpesmJfcKTUCpbsM_xL0JfS49vOpkZ8AUw@mail.gmail.com>
 <CAOesGMjP+QMyuLCykg0nW4yWwmnNtoyzf7nK2dPAWuqcpfp5OA@mail.gmail.com>
Message-ID: <523BA64F.1050607@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2013 07:09 PM, Olof Johansson wrote:
> They do? The hardware I have came with a very old u-boot. Got a link
> to the newer one?

Mainline U-Boot runs nicely on the TrimSlice. Missing functionality
includes PCIe Ethernet and HDMI, but everything else works fine IIRC.
You can flash it using:

https://github.com/NVIDIA/tegra-uboot-flasher-scripts

(read README-developer.txt first, then README-user.txt)
