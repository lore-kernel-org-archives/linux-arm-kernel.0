From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 12 Aug 2013 14:54:39 +0100
Subject: [PATCH 06/22] ARM: dts: bcm281xx: Remove '0x's from BCM11351 DTS
 file
In-Reply-To: <CAGFynZ-+UoML32ecX4nSGAaFJXqQpdq+D8j7GqJSKhxsE7w=9A@mail.gmail.com>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-6-git-send-email-lee.jones@linaro.org>
 <51EDAC90.6010108@broadcom.com> <20130723075309.GE26801@laptop>
 <CAGFynZ-+UoML32ecX4nSGAaFJXqQpdq+D8j7GqJSKhxsE7w=9A@mail.gmail.com>
Message-ID: <20130812135439.GF13851@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 08 Aug 2013, Christian Daudt wrote:

> Hi Lee,
>  I had to change some of the lines in the dts files you modified, so
> I've added your mods. This patch:
> https://lkml.org/lkml/2013/8/8/477
> 
> includes your changes to bcm11351.dtsi and bcm11351-brt.dts. Not sure
> where your patch is at this point, but I just wanted to point that
> out.

I haven't done anything with that patch yet, but I'd prefer they
stayed separate to be honest. If you make your changes and ensure
they're in an upstream tree (and let me know which one), I'll rebase
my patches on top of that tree.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
