From: frankyl@broadcom.com (Franky Lin)
Date: Thu, 14 Jun 2012 09:45:56 -0700
Subject: Where to power on the wifi device before loading the
 driver.
In-Reply-To: <6B4D417B830BC44B8026029FD256F7F1C377BFFE89@HKMAIL01.nvidia.com>
References: <6B4D417B830BC44B8026029FD256F7F1C377BFFE88@HKMAIL01.nvidia.com>
 <4FD8CED9.6030901@broadcom.com>
 <6B4D417B830BC44B8026029FD256F7F1C377BFFE89@HKMAIL01.nvidia.com>
Message-ID: <4FDA1544.1020701@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2012 09:17 PM, Wei Ni wrote:
> Wei: Yes, in OOB mode, it's easy to add a device node in the DT, to pass
> the gpio property to brcmfmac driver. But the NO-OOB mode doesn?t use the
> virtual platform device, so we can't pass the gpio to driver. We need to find
> a way to support these two mode both.
> Could we use the virtual platform device both for OOB and NO-OOB mode? so that
> we can implement power control in these two mode, and we can add a flags to
> control if need to power on or not.

Of course you can use it for non OOB.

> BTW, does that power on sequence is generally for 4329?

Yes.

Regards.
Franky
