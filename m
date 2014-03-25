From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 25 Mar 2014 13:56:45 -0600
Subject: [PATCH v5 1/4] pci: APM X-Gene PCIe controller driver
In-Reply-To: <20140325140510.GF17163@e106497-lin.cambridge.arm.com>
References: <1395270762-6055-1-git-send-email-tinamdar@apm.com>
 <1395270762-6055-2-git-send-email-tinamdar@apm.com>
 <CA+sq2CchcWBieGEH33AJFj6HYy-yiJFgzX94Gtsoho2k3z65eA@mail.gmail.com>
 <CACoXjcn2LuhJsNLpCgfvqT6AQEb1pw70N9GNfgCgZ88myGMNBg@mail.gmail.com>
 <20140325140510.GF17163@e106497-lin.cambridge.arm.com>
Message-ID: <CAErSpo5uyJxvYk42pf0mxRNO6ZSFmQW4AHfe1qGBMDoUiD0BHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 25, 2014 at 8:05 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:

> ... I'm a bit baffled by pci_claim_resource()
> as it doesn't seem to be used by some architectures. Does it mean it
> is not needed unless you have some BIOS setting up resources for you
> and in that case you need to go and claim the resource?

Many architectures don't use pci_claim_resource() yet.  I'm trying to
unify this so all architectures do use it, but it's taking me a long
time to get this done.

Bjorn
