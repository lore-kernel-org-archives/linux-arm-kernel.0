From: jhautbois@gmail.com (Jean-Michel Hautbois)
Date: Wed, 27 Aug 2014 11:11:15 +0200
Subject: imx6 eSATA
In-Reply-To: <20140118184427.GJ15937@n2100.arm.linux.org.uk>
References: <20140118184427.GJ15937@n2100.arm.linux.org.uk>
Message-ID: <CAL8zT=iVVmkT36idmkPFX7PxM7P3A489ThZqirqP3dZNkgmYTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

2014-01-18 19:44 GMT+01:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> So, I see we have AHCI support for SATA on the iMX6.  Great... but it
> doesn't work on the cubox-i, because the phy settings are wrong.
>
> The Cubox-i requires GPR13 set to 0x0593A044 - I haven't decoded what
> this means yet, but it's different from the 0x0593E4A4 which is
> currently hard-coded into the driver (and I've independently tested
> that this is indeed required.)

Pardon me if this is a naive question, but how do you know which value
is required for a specific board ?

Thanks,
JM
