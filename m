From: andy@warmcat.com (=?UTF-8?B?IkFuZHkgR3JlZW4gKOael+WuieW7uCki?=)
Date: Tue, 10 Jul 2012 20:58:58 +0800
Subject: [PATCH 4 0/4] Add ability to set defaultless network device MAC
 addresses to deterministic computed locally administered values
In-Reply-To: <201207101437.54877.florian@openwrt.org>
References: <20120705024259.26317.16000.stgit@build.warmcat.com>
 <201207101437.54877.florian@openwrt.org>
Message-ID: <4FFC2712.9020208@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/12 20:37, the mail apparently from Florian Fainelli included:

Hi -

> Le jeudi 05 juillet 2012 04:44:33, Andy Green a ?crit :
>> The following series adds some code to generate legal, locally administered
>> MAC addresses from OMAP4 CPU Die ID fuse data, and then adds a helper at
>> net/ethernet taking care of accepting device path / MAC mapping
>> registrations and running a notifier to enforce the requested MAC when the
>> matching network device turns up.
>
> This looks like something you can solve by user-space entirely. Expose the

That might seem so from a openwrt perspective, where you custom cook the 
whole userland thing per-device, but it ain't so from a generic rootfs 
perspective.

Why should Ubuntu, Fedora etc stink up their OSes with Panda-specific 
workarounds?  And Panda is not the only device with this issue.

-Andy
