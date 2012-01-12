From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 12 Jan 2012 12:50:54 -0800
Subject: [PATCH 7/9] arm/tegra: emc: device tree bindings
In-Reply-To: <CAPnjgZ2p63C1UNr_RxCcwKjjqJFXzZppXD14hXh85zXH35POrw@mail.gmail.com>
References: <1324599468-12845-1-git-send-email-olof@lixom.net>
 <1324599468-12845-8-git-send-email-olof@lixom.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F18A6@HQMAIL01.nvidia.com>
 <CAOesGMjeVm_PcsBnxfKX9Oe96QUaCsJrvuESCRZq5vwq9gD5xA@mail.gmail.com>
 <CAPnjgZ2p63C1UNr_RxCcwKjjqJFXzZppXD14hXh85zXH35POrw@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17801D1DCF@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon Glass wrote at Thursday, January 12, 2012 1:04 PM:
> On Thu, Jan 5, 2012 at 5:20 PM, Olof Johansson <olof@lixom.net> wrote:
> > On Thu, Jan 5, 2012 at 4:01 PM, Stephen Warren <swarren@nvidia.com> wrote:
> >> Olof Johansson wrote at Thursday, December 22, 2011 5:18 PM:
> >>> Device tree bindings for the EMC tables on tegra.
...
> I am looking at maybe bringing this into U-Boot.
> 
> Do you have an example of the ram-code table? Would it look something like this?

There's an example for Seaboard here:

http://patchwork.ozlabs.org/patch/132929/

The base EMC node was added earlier in the patch series:

http://patchwork.ozlabs.org/patch/132928/

-- 
nvpublic
