From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 22 Apr 2014 19:56:19 -0400
Subject: [PATCH 0/2] net: Add Keystone NetCP ethernet driver support
In-Reply-To: <20140422150231.2e87b7eb@nehalam.linuxnetplumber.net>
References: <1398201675-17379-1-git-send-email-santosh.shilimkar@ti.com>
 <20140422150231.2e87b7eb@nehalam.linuxnetplumber.net>
Message-ID: <535701A3.5050309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 April 2014 06:02 PM, Stephen Hemminger wrote:
> On Tue, 22 Apr 2014 17:21:13 -0400
> Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> 
>> NetCP driver has a plug-in module architecture where each of the NetCP
>> sub-modules exist as a loadable kernel module which plug in to the netcp
>> core. These sub-modules are represented as "netcp-devices" in the dts
>> bindings. It is mandatory to have the ethernet switch sub-module for
>> the ethernet interface to be operational. Any other sub-module like the
>> PA is optional.
> 
> Where is the implementation of these modules. You need to include
> this as separate patch set. Also the hooks for these modules should all
> be EXPORT_SYMBOL_GPL() to disallow proprietary modules.
> 
There is no proprietary issue and all the hooks will be GPL. The plan is
to add them in another patch-set once the core driver gets merged. They need
some work to make them upstream ready.

Regards,
Santosh
