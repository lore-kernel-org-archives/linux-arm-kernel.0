From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 03 Feb 2014 23:07:39 +0100
Subject: [PATCH v5 00/14] ahci: library-ise ahci_platform, add sunxi driver
 and cleanup imx driver
In-Reply-To: <20140203160936.GC30250@htj.dyndns.org>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com>
 <20140203160936.GC30250@htj.dyndns.org>
Message-ID: <52F0132B.8090008@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/03/2014 05:09 PM, Tejun Heo wrote:
> Hello,
> 
> On Wed, Jan 22, 2014 at 08:04:35PM +0100, Hans de Goede wrote:
>> Here is v4 of my patchset for adding ahci-sunxi support. It has grown quite
>> a bit since I've been going for a more generic approach this time and I've
>> also cleaned up the ahci-imx driver to use the same generic approach.
> 
> On top of which tree were these patches generated?  They don't apply
> to 3.14-rc1.

They are on top of 3.13, I'll rebase them, address Maxime's review of
the dts bits and send a new version sometime during the next couple of days.

Thanks,

Hans
