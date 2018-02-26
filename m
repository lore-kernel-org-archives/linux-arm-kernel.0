From: tony@atomide.com (Tony Lindgren)
Date: Mon, 26 Feb 2018 13:34:11 -0800
Subject: [PATCH 11/12] PM / AVS: SmartReflex: Prepare to use device tree
 based probing
In-Reply-To: <5d37e6ff-9b89-b677-859e-6eeae5527276@intel.com>
References: <20180223210100.86732-1-tony@atomide.com>
 <20180223210100.86732-12-tony@atomide.com>
 <5d37e6ff-9b89-b677-859e-6eeae5527276@intel.com>
Message-ID: <20180226213411.GD16043@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rafael J. Wysocki <rafael.j.wysocki@intel.com> [180226 10:38]:
> On 2/23/2018 10:00 PM, Tony Lindgren wrote:
> > We are currently probing smartreflex with omap_device while we are
> > already probing smartreflex related interconnect target module with
> > ti-sysc driver and dts data.
...
> You need an ACK from Kevin Hilman on this anyway and if you receive one,
> please feel free to route it whatever way is convenient for you.

Oops sorry about that Kevin. I did the Cc list from memory and
totally forgot about the MAINTAINERS entry for AVS drivers. I'll
also bounce the original email to Kevin for easier reading.

Regards,

Tony
