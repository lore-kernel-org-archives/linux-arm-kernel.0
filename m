From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Aug 2017 17:04:43 -0500
Subject: [PATCH] PCI: Convert to using %pOF instead of full_name
In-Reply-To: <20170802223928.GQ20308@bhelgaas-glaptop.roam.corp.google.com>
References: <20170718214339.7774-41-robh@kernel.org>
 <20170802223928.GQ20308@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <CAL_JsqLznQdnWw+A2T8V8CTktYaPDF_800jGHAVa=G-Yhxyn+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 2, 2017 at 5:39 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Jul 18, 2017 at 04:43:21PM -0500, Rob Herring wrote:
>> Now that we have a custom printf format specifier, convert users of
>> full_name to use %pOF instead. This is preparation to remove storing
>> of the full path string for each node.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: Jonathan Hunter <jonathanh@nvidia.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: linux-pci at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-tegra at vger.kernel.org
>> Cc: linuxppc-dev at lists.ozlabs.org
>
> Applied to pci/misc for v4.14, thanks!

This hasn't shown up in -next.

Rob
