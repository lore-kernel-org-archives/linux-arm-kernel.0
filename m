From: stephen@networkplumber.org (Stephen Hemminger)
Date: Thu, 21 Aug 2014 19:48:38 -0700
Subject: [PATCH v2 2/3] net: Add Keystone NetCP ethernet driver
In-Reply-To: <1408115562-22487-3-git-send-email-santosh.shilimkar@ti.com>
References: <1408115562-22487-1-git-send-email-santosh.shilimkar@ti.com>
 <1408115562-22487-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20140821194838.32f2c3f1@uryu.home.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Aug 2014 11:12:41 -0400
Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:

> NetCP driver has a plug-in module architecture where each of the NetCP
> sub-modules exist as a loadable kernel module which plug in to the netcp
> core. These sub-modules are represented as "netcp-devices" in the dts
> bindings. It is mandatory to have the ethernet switch sub-module for
> the ethernet interface to be operational. Any other sub-module like the
> PA is optional.

What are you doing to prevent/discourage proprietary binary only
sub-modules?
