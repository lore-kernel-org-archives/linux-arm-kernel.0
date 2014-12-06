From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Sat, 6 Dec 2014 10:50:57 -0800
Subject: [RFC PATCH v2 4/4] arm64:numa: adding numa support for arm64
 platforms.
In-Reply-To: <5482ce36.c9e2420a.5d40.71c7SMTPIN_ADDED_BROKEN@mx.google.com>
References: <1416605010-10442-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1416605010-10442-5-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <5482ce36.c9e2420a.5d40.71c7SMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <CAFpQJXU89uwAkHyi+dvHmbZOvadO_EyQbrG8jMo5G3tnWP5qcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 6, 2014 at 1:36 AM, Ashok Kumar <ashoks@broadcom.com> wrote:
> On Sat, Nov 22, 2014 at 02:53:30AM +0530, Ganapatrao Kulkarni wrote:
>> Adding numa support for arm64 based platforms.
>> creating numa mapping by parsing the dt node numa-map.
>>
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
> Ganapat,
>
> Can we get a simple version of this patchset with just the associativity parameter for the cpu and memory nodes
> upstream? The initial patchset can be with the assumption of a simple full mesh topology for the distance.  The
> hierarchical complex topologies and the DT nodes and properties for that can be added in a later patch, once the
> standard for that is agreed upon.
> We are planning to support ACPI based NUMA for                                                                        Broadcom Vulcan processors(http://www.broadcom.com/press/release.php?id=s797235).
> I am working on a patch to add support for the SRAT and SLIT ACPI tables based on your patch and I will post that
> patchset soon, so it will be helpful if the core changes are upstream.
>
to implement, ibm/ppc like implementation, we need efi-stub patch to
not remove the memory node from the dt.
current efi-stub parses dt file and removes memory nodes.
can i get the efi-stub patch to start with please?

> Thanks,
> Ashok
>

thanks
ganapat
