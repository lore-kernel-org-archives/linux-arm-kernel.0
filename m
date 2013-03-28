From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 28 Mar 2013 08:49:20 -0600
Subject: 3.9-rc1 regression in arm dtb build
In-Reply-To: <20130328092916.GA11187@amd.pavel.ucw.cz>
References: <20130306193332.GA6022@amd.pavel.ucw.cz>
 <5137C404.9060902@wwwdotorg.org> <20130307144506.GB7344@amd.pavel.ucw.cz>
 <5138FDAE.8060202@wwwdotorg.org> <20130311050546.GA21863@quad.lixom.net>
 <CACxGe6vkC7fjzf1-+K8O81+w=jQ63PvuTEhSPyitEBA9XiKYnw@mail.gmail.com>
 <20130328092916.GA11187@amd.pavel.ucw.cz>
Message-ID: <51545870.4010209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2013 03:29 AM, Pavel Machek wrote:
...
> There's change that makes it pretty much impossible to build dtbs
> reliably between different kernel versions, because it leaves old dtbs
> around, and they survive even make clean.

One question here: Presumably the dtbs don't survive "make clean" if you
run that right after building the dtbs, but only if you check out a new
kernel version before running clean? Or is that not the case?
